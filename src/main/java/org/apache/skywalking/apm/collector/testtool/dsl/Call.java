package org.apache.skywalking.apm.collector.testtool.dsl;

/**
 * @author peng-yongsheng
 */
public class Call {
    private String target;
    private int duration;
    private int durationAtNetwork;
    private ErrorEnum error;

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getDurationAtNetwork() {
        return durationAtNetwork;
    }

    public void setDurationAtNetwork(int durationAtNetwork) {
        this.durationAtNetwork = durationAtNetwork;
    }

    public ErrorEnum getError() {
        return error;
    }

    public void setError(ErrorEnum error) {
        this.error = error;
    }
}
