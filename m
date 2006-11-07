From: Ian Kent <raven@themaw.net>
Subject: Re: NFS+AUTOFS: Strange connections every 2 minutes
Date: Tue, 07 Nov 2006 20:06:46 +0800
Message-ID: <1162901206.18975.40.camel@localhost>
References: <20061107105134.3618b93b@notebook.chaosbringer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20061107105134.3618b93b@notebook.chaosbringer.de>
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
To: Julian Hagenauer <chaosbringer@gmx.de>
Cc: autofs@linux.kernel.org

On Tue, 2006-11-07 at 10:51 +0100, Julian Hagenauer wrote:
> Hi,
> i think it is a autofs and not nfs-related problem, because it does not occur,if i have stopped the automounter.
> I set up a nfs-share to get mounted with tcp by the automounter, but even if i do not access the share on client-side, tcp-connections still persist.

It's way to early to start looking at packets.
In any case autofs uses mount(8) and so a packet trace is usually not
useful.

> Those are the connections that permanently persist:

What do you mean permanently persist.
They are connections that have been closed and are going away after
TIME_WAIT seconds.

> tcp      6 13 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=933 dport=111 packets=6 bytes=364 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=933 packets=4 bytes=408 [ASSURED] use=1
> tcp      6 16 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=1023 dport=2049 packets=10 bytes=896 src=192.168.1.9 dst=192.168.1.4 sport=2049 dport=1023 packets=7 bytes=584 [ASSURED] use=1
> tcp      6 13 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=934 dport=878 packets=6 bytes=412 src=192.168.1.9 dst=192.168.1.4 sport=878 dport=934 packets=4 bytes=280 [ASSURED] use=1
> tcp      6 16 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=937 dport=111 packets=6 bytes=380 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=937 packets=4 bytes=248 [ASSURED] use=1
> tcp      6 13 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=936 dport=111 packets=6 bytes=380 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=936 packets=4 bytes=248 [ASSURED] use=1
> tcp      6 16 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=938 dport=878 packets=6 bytes=412 src=192.168.1.9 dst=192.168.1.4 sport=878 dport=938 packets=4 bytes=244 [ASSURED] use=1
> 
> If the TIME_WAIT period is over, new TCP-Connections are done and i have again 6 connections in Time_Wait state:

If you have a process that is periodically trying to access something in
an automount managed mount then this is exactly what you will see.

> 
> tcp      6 43 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=1023 dport=2049 packets=10 bytes=896 src=192.168.1.9 dst=192.168.1.4 sport=2049 dport=1023 packets=7 bytes=584 [ASSURED] use=1
> tcp      6 40 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=953 dport=111 packets=6 bytes=380 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=953 packets=4 bytes=248 [ASSURED] use=1
> tcp      6 43 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=955 dport=878 packets=6 bytes=412 src=192.168.1.9 dst=192.168.1.4 sport=878 dport=955 packets=4 bytes=244 [ASSURED] use=1
> tcp      6 40 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=951 dport=878 packets=6 bytes=412 src=192.168.1.9 dst=192.168.1.4 sport=878 dport=951 packets=4 bytes=280 [ASSURED] use=1
> tcp      6 43 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=954 dport=111 packets=6 bytes=380 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=954 packets=4 bytes=248 [ASSURED] use=1
> tcp      6 40 TIME_WAIT src=192.168.1.4 dst=192.168.1.9 sport=950 dport=111 packets=6 bytes=364 src=192.168.1.9 dst=192.168.1.4 sport=111 dport=950 packets=4 bytes=408 [ASSUERD] use=1
> 

snip ...

> Again, if i stop the automounter the TIME-WAIT-connections are closed and no new ones are made.
> I want no connection to persist, if the automounter has not mounted anything.
> How can i accomblish that?

It could be something else but experience so far has shown that this is
caused by some process continually accessing mount points. Unless there
is other evidence I can only recommend you find the process that's
scanning the directory tree or trying to access your automount
directories and fix it.

Ian
