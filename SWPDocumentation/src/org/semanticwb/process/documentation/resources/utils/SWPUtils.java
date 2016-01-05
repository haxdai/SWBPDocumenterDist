package org.semanticwb.process.documentation.resources.utils;

import com.lowagie.text.Font;
import com.lowagie.text.rtf.style.RtfFont;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.jsoup.Jsoup;
import org.jsoup.select.Elements;
import org.semanticwb.Logger;
import org.semanticwb.SWBPlatform;
import org.semanticwb.SWBPortal;
import org.semanticwb.SWBUtils;
import org.semanticwb.model.Descriptiveable;
import org.semanticwb.model.SWBComparator;
import org.semanticwb.model.VersionInfo;
import org.semanticwb.model.WebSite;
import org.semanticwb.platform.SemanticClass;
import org.semanticwb.platform.SemanticObject;
import org.semanticwb.platform.SemanticProperty;
import org.semanticwb.portal.api.SWBResourceModes;
import org.semanticwb.portal.api.SWBResourceURL;
import org.semanticwb.portal.api.SWBResourceURLImp;
import org.semanticwb.process.documentation.model.Activity;
import org.semanticwb.process.documentation.model.DocumentSection;
import org.semanticwb.process.documentation.model.DocumentSectionInstance;
import org.semanticwb.process.documentation.model.Documentation;
import org.semanticwb.process.documentation.model.DocumentationInstance;
import org.semanticwb.process.documentation.model.ElementReference;
import org.semanticwb.process.documentation.model.FreeText;
import org.semanticwb.process.documentation.model.Instantiable;
import org.semanticwb.process.documentation.model.Model;
import org.semanticwb.process.documentation.model.Referable;
import org.semanticwb.process.documentation.model.SectionElement;
import org.semanticwb.process.documentation.model.SectionElementRef;
import org.semanticwb.process.documentation.model.TemplateContainer;
import org.semanticwb.process.model.RepositoryDirectory;
import org.semanticwb.process.model.RepositoryElement;
import org.semanticwb.process.model.RepositoryFile;
import org.semanticwb.process.model.RepositoryURL;
import org.semanticwb.process.model.Process;
import org.semanticwb.process.resources.ProcessFileRepository;
import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 * Clase utilitaria para los componentes de documentación de procesos.
 * @author carlos.alvarez
 */
public class SWPUtils {
    public final static String FORMAT_PNG = "png";
    public final static String FORMAT_SVG = "svg";
    private final static Logger log = SWBUtils.getLogger(SWPUtils.class);

    public static void copyFileFromSWBAdmin(String source, String destination, String fileName) throws FileNotFoundException, IOException {
        InputStream inputStream = SWBPortal.getAdminFileStream(source);
        File css = new File(destination);
        if (!css.exists()) {
            css.mkdirs();
        }

        File file = new File(css.getAbsolutePath() + fileName);
        OutputStream outputStream = new FileOutputStream(file);
        byte[] buffer = new byte[1024];
        int len;
        while ((len = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, len);
        }
        outputStream.close();
        inputStream.close();
    }

    public static void copyFile(String sourceFile, String destFile) throws IOException {//TODO: Revisar por qué es necesario esto en lugar de SWBUtils.IO.copyStream
        InputStream inStream = null;
        OutputStream outStream = null;
        try {
            File afile = new File(sourceFile);
            File bfile = new File(destFile);
            inStream = new FileInputStream(afile);
            outStream = new FileOutputStream(bfile);
            byte[] buffer = new byte[1024];
            int length;
            //copy the file content in bytes 
            while ((length = inStream.read(buffer)) > 0) {
                outStream.write(buffer, 0, length);
            }
            inStream.close();
            outStream.close();
        } catch (IOException e) {
            System.err.println("Error to copy file " + sourceFile + ", " + e.getMessage());
        }
    }

    public static void generateImageModel(org.semanticwb.process.model.Process p, String path, String format, String data, double width, double height) {
        try {
            //String basePathDest = SWBPortal.getWorkPath() + "/models/" + p.getProcessSite().getId() + "/Resource/" + p.getId() + "/download/rep_files/";
            File baseDir = new File(path);
            if (!baseDir.exists()) {
                baseDir.mkdirs();
            }
            FileOutputStream out = new FileOutputStream(baseDir + "/" + p.getId() + "." + format);
            if (format.equals(FORMAT_SVG)) {
                String svg = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n"
                        + "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n";
                svg += data;
                svg = svg.replace("<g id=\"data\" bclass=\"itemaware\" oclass=\"itemaware_o\">", "<g id=\"data\" bclass=\"itemaware\" oclass=\"itemaware_o\" class=\"itemAware\">");
                svg = svg.replace("<g id=\"dataStore\" bclass=\"itemaware\" oclass=\"itemaware_o\" transform=\"translate(-12,-10)\">", "<g id=\"dataStore\" bclass=\"itemaware\" oclass=\"itemaware_o\" transform=\"translate(-12,-10)\" class=\"itemAware\">");
                svg = svg.replace("style=\"display: none;\"", "");
                out.write(svg.getBytes("ISO-8859-1"));
            } else if (format.equals(FORMAT_PNG)) {
                //Fix image dimensions
                String widthKey = "width=\"";
                String heightKey = "height=\"";
                if (data.contains(widthKey)) {
                    int idx = data.indexOf(widthKey);
                    int idx2 = data.indexOf("\"", idx + widthKey.length());
                    data = data.substring(0, idx) + widthKey + width + "\"" + data.substring(idx2 + 1, data.length());
                }
                if (data.contains(heightKey)) {
                    int idx = data.indexOf(heightKey);
                    int idx2 = data.indexOf("\"", idx + heightKey.length());
                    data = data.substring(0, idx) + heightKey + height + "\"" + data.substring(idx2 + 1, data.length());
                }

                InputStream strStream = new ByteArrayInputStream(data.getBytes("ISO-8859-1"));
                TranscoderInput ti = new TranscoderInput(strStream/*svgFile.toURI().toString()*/);
                TranscoderOutput to = new TranscoderOutput(out);

                PNGTranscoder t = new PNGTranscoder();
                t.addTranscodingHint(PNGTranscoder.KEY_WIDTH, new Float(width) + 100);
                t.addTranscodingHint(PNGTranscoder.KEY_HEIGHT, new Float(height) + 100);
                t.addTranscodingHint(PNGTranscoder.KEY_FORCE_TRANSPARENT_WHITE, Boolean.TRUE);
                t.transcode(ti, to);
            }
            out.flush();
            out.close();

        } catch (Exception e) {
        }
    }

    public static void saveFile(String src, String dest) {
        try {
            URL url = new URL(src);
            InputStream is = url.openStream();
            OutputStream os = new FileOutputStream(dest);

            byte[] b = new byte[2048];
            int length;

            while ((length = is.read(b)) != -1) {
                os.write(b, 0, length);
            }
            is.close();
            os.close();
        } catch (Exception e) {
            log.error("Error on saveFile, " + e.getMessage() + ", " + e.getCause());
        }
    }

    public static class FONTS {

        public static final Font body = new RtfFont("Arial", 10);
        public static final Font h = new RtfFont("Arial", 8);
        public static final Font h1 = new RtfFont("Arial", 16, Font.BOLD);
        public static final Font h2 = new RtfFont("Arial", 14, Font.BOLDITALIC);
        public static final Font h3 = new RtfFont("Arial", 13, Font.BOLD);
        public static final Font th = new RtfFont("Arial", 10, Font.BOLD);
        public static final Font td = new RtfFont("Arial", 9);
    }
}
