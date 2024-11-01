package projectdta.simulations;

@license(LGPL);

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;

network MixedWLAN
{
    parameters:
        int numHostsUDP;
        int numHostsTCP;
        **.mgmt.numChannels = 2;
        @display("bgb=496,206");
    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            parameters:
                // @display("p=100,300;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                config = xml("<config><interface hosts='*' address='145.236.x.x' netmask='255.255.0.0'/></config>");
                // @display("p=100,100;is=s");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                // @display("p=100,200;is=s");
        }
        udphost[numHostsUDP]: WirelessHost {
            @display("r=,,#707070;");
            wlan[*].mgmt.typename = "Ieee80211MgmtStaSimplified";
            wlan[*].agent.typename = "";
        }
        tcphost[numHostsTCP]: WirelessHost {
            @display("r=,,#707070;");
            wlan[*].mgmt.typename = "Ieee80211MgmtStaSimplified";
            wlan[*].agent.typename = "";
        }
        ap: AccessPoint {
            @display("r=,,#707070;p=25,25");
            wlan[*].mgmt.typename = "Ieee80211MgmtApSimplified";
        }
}

