From: John Saalwaechter <bababooey182@yahoo.com>
Subject: autofs Bug ?
Date: Fri, 26 Mar 2004 14:44:02 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040326224402.73235.qmail@web41108.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Roland, I'm very interested in your comments.  I'm in an
environment with a relatively sophisticated automounter
setup, with Sun, SGI, HP-UX, and Linux machines.  The Linux
machines are mostly stock Red Hat 9, with its default autofs.

Occasionally the automounter on multiple Linux machines will
completely stop functioning, which correlates to them being
stuck in the "D" state in "ps ax" output.  Attempts to simply
stop and restart the automounters with
"/etc/init.d/autofs stop; /etc/init.d/autofs start" always
make the problem worse.  After the restart the load on the
Linux box will rise until it's high, and there will be multiple
automount daemons for the same mount point.  A full system
reboot is the only solution we have right now for this situation.
I also suspect that the affected systems are all multiprocessors.

You mention sending the USR1 signal in the stop method, then
pausing, then sending USR2.  Why did you think to do that?  Can
you please post your modified /etc/init.d/autofs script, or at
least the stop method?  That would be greatly appreciated.

Thanks.

>I have installed autofs-4.1.0-1 on a Fedora Core 1 System with
>Kernel 2.4.22-1.2174.nptlsmp
>
>Often the System crashes, when an USR2 Signal is sent
>to an automount process.
>This happens under the following conditions:
>
>- there exists a (Network-) filesystem actually mounted
>  by that automount process and
>- this filesystem is umountable (not busy), but still mounted.
>- the Kernel is a smp-Kernel
>  (2.4.22-1.2174.nptlsmp or 2.4.22-1.2115.nptlsmp)
>
>Note: autofs-3.1.7-42 does the same thing.
>      The problem did not occur under Single Processor Kernels
>
>My workaround for the first time is changing the "stop" function in
>/etc/init.d/autofs
>Send USR1 instead of USR2, wait a little bit, and then send USR2.
>This seems to help avoiding the crash.
>
>Sincerely,
>
>Roland Pfretzschner


__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
