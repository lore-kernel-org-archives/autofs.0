From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
Subject: Autofs4 still in testing?
Date: Sun, 21 Mar 2004 14:03:04 +0200 (EET)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403211359270.875@dsl-hkigw4n53.dial.inet.fi>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi!

On Linux 2.6.5-rc2 you can see this on fs/Kconfig file:

config AUTOFS4_FS
        tristate "Kernel automounter version 4 support (also supports v3)"
        help
          The automounter is a tool to automatically mount remote file systems
          on demand. This implementation is partially kernel-based to reduce
          overhead in the already-mounted case; this is unlike the BSD
          automounter (amd), which is a pure user space daemon.

          To use the automounter you need the user-space tools from
          <ftp://ftp.kernel.org/pub/linux/daemons/autofs/testing-v4/>; you also
          want to answer Y to "NFS file system support", below.

          To compile this support as a module, choose M here: the module will be
          called autofs4.  You will need to add "alias autofs autofs4" to your
          modules configuration file.

          If you are not a part of a fairly large, distributed network or
          don't have a laptop which needs to dynamically reconfigure to the
          local network, you probably do not need an automounter, and can say
          N here.


I wonder if <ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/> is a better
link?

Petri
