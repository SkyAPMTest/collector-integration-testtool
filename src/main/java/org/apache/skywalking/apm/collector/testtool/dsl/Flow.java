package org.apache.skywalking.apm.collector.testtool.dsl;

import java.util.List;

/**
 * @author peng-yongsheng
 */
public class Flow {

    private String source;
    private List<Call> calls;

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public List<Call> getCalls() {
        return calls;
    }

    public void setCalls(List<Call> calls) {
        this.calls = calls;
    }
}
