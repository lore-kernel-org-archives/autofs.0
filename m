From: "Paul Wankadia" <junyer@gmail.com>
Subject: another make issue
Date: Mon, 3 Nov 2008 12:18:39 +1100
Message-ID: <510ca9b40811021718j43583340p38cec31f35cc87ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

...
make[1]: Entering directory `/home/junyer/autofs/samples'
install -d -m 755 /etc
install -d -m 755
install: missing file operand
Try `install --help' for more information.
make[1]: *** [dirs] Error 1
make[1]: Leaving directory `/home/junyer/autofs/samples'
...

samples/Makefile:

    19  .PHONY: dirs
    20  dirs:
    21          install -d -m 755 $(INSTALLROOT)$(autofsmapdir)
    22          install -d -m 755 $(INSTALLROOT)$(autofsconfdir)
    23          install -d -m 755 $(INSTALLROOT)$(autofslibdir)
    24          install -d -m 755 $(INSTALLROOT)/var/run/autofs

Makefile.conf:

    68  # Location for configuration init script
    69  autofsconfdir =

autofsconfdir should have a sane default?
