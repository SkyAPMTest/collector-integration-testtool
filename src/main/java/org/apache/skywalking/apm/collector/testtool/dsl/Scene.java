package org.apache.skywalking.apm.collector.testtool.dsl;

import java.util.List;

/**
 * @author peng-yongsheng
 */
public class Scene {

    private List<Flow> flows;

    public List<Flow> getFlows() {
        return flows;
    }

    public void setFlows(List<Flow> flows) {
        this.flows = flows;
    }
}
