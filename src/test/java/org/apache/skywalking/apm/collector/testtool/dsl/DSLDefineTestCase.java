package org.apache.skywalking.apm.collector.testtool.dsl;

import java.io.FileNotFoundException;
import java.io.Reader;
import org.apache.skywalking.apm.collector.testtool.utils.ResourceUtils;
import org.junit.Assert;
import org.junit.Test;
import org.yaml.snakeyaml.Yaml;

/**
 * @author peng-yongsheng
 */
public class DSLDefineTestCase {

    @Test
    public void test() throws FileNotFoundException {
        Reader applicationReader = ResourceUtils.read("scene/sample.yml");
        Yaml yaml = new Yaml();
        Scene scene = yaml.loadAs(applicationReader, Scene.class);

        Assert.assertEquals(2, scene.getFlows().size());
        Assert.assertEquals("Test Source 1", scene.getFlows().get(0).getSource());
    }
}
