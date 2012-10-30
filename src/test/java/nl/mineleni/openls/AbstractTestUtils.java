/**
 * 
 */
package nl.mineleni.openls;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.List;

/**
 * AbstractTestUtils bevat utility test methoden.
 * 
 * @author Mark
 */
public class AbstractTestUtils {

    /**
     * List directory filenames.
     * 
     * @param folder
     *            the folder
     * @param list
     *            the list
     */
    protected void listDirectoryFilenames(final File folder,
            final List<File> list) {
        folder.setReadOnly();
        final File[] files = folder.listFiles();
        for (final File file : files) {
            if (file.getName().endsWith(".xml")) {
                list.add(file);
            }
            if (file.isDirectory()) {
                this.listDirectoryFilenames(file, list);
            }
        }
    }

    /**
     * Read file as string.
     * 
     * @param filePath
     *            the file path
     * @return inhoud van de file als string
     * @throws IOException
     *             Signals that an I/O exception has occurred.
     */
    protected String readFileAsString(final String filePath)
            throws java.io.IOException {
        final URL url = this.getClass().getResource(filePath);
        final File file = new File(url.getFile());
        final byte[] buffer = new byte[(int) file.length()];
        final BufferedInputStream f = new BufferedInputStream(
                new FileInputStream(file));
        f.read(buffer);
        f.close();
        return new String(buffer);
    }
}
