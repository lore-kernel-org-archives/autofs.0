From: Julian Hagenauer <chaosbringer@gmx.de>
Subject: NFS+AUTOFS: Strange connections every 2 minutes
Date: Tue, 7 Nov 2006 10:51:34 +0100
Message-ID: <20061107105134.3618b93b@notebook.chaosbringer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi,
i think it is a autofs and not nfs-related problem, because it does not occur,if i have stopped the automounter.
I set up a nfs-share to get mounted with tcp by the automounter, but even if i do not access the share on client-side, tcp-connections still persist.
Those are the connections that permanently persist:
tcp      6 13 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=933 dport=111 packets=6 bytes=364 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=933 packets=4 bytes=408 [ASSURED] use=1
tcp      6 16 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=1023 dport=2049 packets=10 bytes=896 src=192.168.1.9 dst=192.168.1.4 sport=2049 dport=1023 packets=7 bytes=584 [ASSURED] use=1
tcp      6 13 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=934 dport=878 packets=6 bytes=412 src=192.168.1.9 dst=192.168.1.4 sport=878 dport=934 packets=4 bytes=280 [ASSURED] use=1
tcp      6 16 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=937 dport=111 packets=6 bytes=380 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=937 packets=4 bytes=248 [ASSURED] use=1
tcp      6 13 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=936 dport=111 packets=6 bytes=380 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=936 packets=4 bytes=248 [ASSURED] use=1
tcp      6 16 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=938 dport=878 packets=6 bytes=412 src=192.168.1.9 dst=192.168.1.4 sport=878 dport=938 packets=4 bytes=244 [ASSURED] use=1

If the TIME_WAIT period is over, new TCP-Connections are done and i have again 6 connections in Time_Wait state:

tcp      6 43 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=1023 dport=2049 packets=10 bytes=896 src=192.168.1.9 dst=192.168.1.4 sport=2049 dport=1023 packets=7 bytes=584 [ASSURED] use=1
tcp      6 40 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=953 dport=111 packets=6 bytes=380 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=953 packets=4 bytes=248 [ASSURED] use=1
tcp      6 43 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=955 dport=878 packets=6 bytes=412 src=192.168.1.9 dst=192.168.1.4 sport=878 dport=955 packets=4 bytes=244 [ASSURED] use=1
tcp      6 40 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=951 dport=878 packets=6 bytes=412 src=192.168.1.9 dst=192.168.1.4 sport=878 dport=951 packets=4 bytes=280 [ASSURED] use=1
tcp      6 43 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=954 dport=111 packets=6 bytes=380 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=954 packets=4 bytes=248 [ASSURED] use=1
tcp      6 40 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=950 dport=111 packets=6 bytes=364 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=950 packets=4 bytes=408 [ASSUERD] use=1

192.168.1.4 (head) is the host running the automounter, host 192.168.1.9 (master) exoprts the nfs-share.

This is the network traffic that occurs, if the TIME_WAIT-state is over:

10:40:05.518935 IP head.chaosbringer.de.904 > master.chaosbringer.de.sunrpc: S 153268036:153268036(0) win 5840 <mss 1460,sackOK,timestamp 356855 0,nop,wscale 2>
10:40:05.519385 IP master.chaosbringer.de.sunrpc > head.chaosbringer.de.904: S 324011551:324011551(0) ack 153268037 win 5792 <mss 1460,sackOK,timestamp 647056 356855,nop,wscale 2>
10:40:05.519459 IP head.chaosbringer.de.904 > master.chaosbringer.de.sunrpc: . ack 1 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.519503 IP head.chaosbringer.de.904 > master.chaosbringer.de.sunrpc: P 1:45(44) ack 1 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.519552 IP master.chaosbringer.de.sunrpc > head.chaosbringer.de.904: . ack 45 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.519783 IP master.chaosbringer.de.sunrpc > head.chaosbringer.de.904: P 1:193(192) ack 45 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.519822 IP head.chaosbringer.de.904 > master.chaosbringer.de.sunrpc: . ack 193 win 1728 <nop,nop,timestamp 356855 647056>
10:40:05.519844 IP head.chaosbringer.de.904 > master.chaosbringer.de.sunrpc: F 45:45(0) ack 193 win 1728 <nop,nop,timestamp 356855 647056>
10:40:05.519876 IP head.chaosbringer.de.905 > master.chaosbringer.de.878: S 150557155:150557155(0) win 5840 <mss 1460,sackOK,timestamp 356855 0,nop,wscale 2>
10:40:05.519951 IP master.chaosbringer.de.878 > head.chaosbringer.de.905: S 322818012:322818012(0) ack 150557156 win 5792 <mss 1460,sackOK,timestamp 647056 356855,nop,wscale 2>
10:40:05.519969 IP master.chaosbringer.de.sunrpc > head.chaosbringer.de.904: F 193:193(0) ack 46 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.519996 IP head.chaosbringer.de.905 > master.chaosbringer.de.878: . ack 1 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.520012 IP head.chaosbringer.de.904 > master.chaosbringer.de.sunrpc: . ack 194 win 1728 <nop,nop,timestamp 356855 647056>
10:40:05.520044 IP head.chaosbringer.de.905 > master.chaosbringer.de.878: P 1:93(92) ack 1 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.520079 IP master.chaosbringer.de.878 > head.chaosbringer.de.905: . ack 93 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.520338 IP master.chaosbringer.de.878 > head.chaosbringer.de.905: P 1:65(64) ack 93 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.520460 IP head.chaosbringer.de.905 > master.chaosbringer.de.878: . ack 65 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.520550 IP head.chaosbringer.de.907 > master.chaosbringer.de.sunrpc: S 153820432:153820432(0) win 5840 <mss 1460,sackOK,timestamp 356855 0,nop,wscale 2>
10:40:05.520578 IP master.chaosbringer.de.sunrpc > head.chaosbringer.de.907: S 327819385:327819385(0) ack 153820433 win 5792 <mss 1460,sackOK,timestamp 647056 356855,nop,wscale 2>
10:40:05.520614 IP head.chaosbringer.de.907 > master.chaosbringer.de.sunrpc: . ack 1 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.520649 IP head.chaosbringer.de.907 > master.chaosbringer.de.sunrpc: P 1:61(60) ack 1 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.520671 IP master.chaosbringer.de.sunrpc > head.chaosbringer.de.907: . ack 61 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.520767 IP master.chaosbringer.de.sunrpc > head.chaosbringer.de.907: P 1:33(32) ack 61 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.520797 IP head.chaosbringer.de.907 > master.chaosbringer.de.sunrpc: . ack 33 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.520813 IP head.chaosbringer.de.907 > master.chaosbringer.de.sunrpc: F 61:61(0) ack 33 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.520826 IP head.chaosbringer.de.905 > master.chaosbringer.de.878: F 93:93(0) ack 65 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.521527 IP head.chaosbringer.de.0 > master.chaosbringer.de.nfs: 0 proc-285212672
10:40:05.521562 IP master.chaosbringer.de.nfs > head.chaosbringer.de.0: reply ok 0 proc-285212672
10:40:05.521586 IP master.chaosbringer.de.sunrpc > head.chaosbringer.de.907: F 33:33(0) ack 62 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.521608 IP master.chaosbringer.de.878 > head.chaosbringer.de.905: F 65:65(0) ack 94 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.521652 IP head.chaosbringer.de.1023 > master.chaosbringer.de.nfs: . ack 326267030 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.521667 IP head.chaosbringer.de.907 > master.chaosbringer.de.sunrpc: . ack 34 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.521673 IP head.chaosbringer.de.905 > master.chaosbringer.de.878: . ack 66 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.521689 IP head.chaosbringer.de.4064747613 > master.chaosbringer.de.nfs: 44 null
10:40:05.521716 IP master.chaosbringer.de.nfs > head.chaosbringer.de.1023: . ack 44 win 1448 <nop,nop,timestamp 647056 356855>
10:40:05.521783 IP master.chaosbringer.de.nfs > head.chaosbringer.de.4064747613: reply ok 28 null
10:40:05.521815 IP head.chaosbringer.de.1023 > master.chaosbringer.de.nfs: . ack 29 win 1460 <nop,nop,timestamp 356855 647056>
10:40:05.521830 IP head.chaosbringer.de.4081524829 > master.chaosbringer.de.nfs: 104 getattr [|nfs]
10:40:05.521875 IP master.chaosbringer.de.nfs > head.chaosbringer.de.4081524829: reply ok 100 getattr [|nfs]
10:40:05.521922 IP head.chaosbringer.de.4098302045 > master.chaosbringer.de.nfs: 104 fsstat [|nfs]
10:40:05.521970 IP master.chaosbringer.de.nfs > head.chaosbringer.de.4098302045: reply ok 52 fsstat [|nfs]
10:40:05.522685 IP head.chaosbringer.de.4115079261 > master.chaosbringer.de.nfs: 116 lookup [|nfs]
10:40:05.522777 IP master.chaosbringer.de.nfs > head.chaosbringer.de.4115079261: reply ok 32 lookup [|nfs]
10:40:05.554852 IP head.chaosbringer.de.1023 > master.chaosbringer.de.nfs: . ack 213 win 1460 <nop,nop,timestamp 356859 647056>
10:40:07.776733 IP head.chaosbringer.de.908 > master.chaosbringer.de.sunrpc: S 151994660:151994660(0) win 5840 <mss 1460,sackOK,timestamp 35.
.
.

Again, if i stop the automounter the TIME-WAIT-connections are closed and no new ones are made.
I want no connection to persist, if the automounter has not mounted anything.
How can i accomblish that?

Thank you very much,
Julian 
