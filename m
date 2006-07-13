From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: -hosts and -null enabling for autofs v4.1.x
Date: Thu, 13 Jul 2006 09:42:54 -0400
Message-ID: <x49u05laae9.fsf@segfault.boston.redhat.com>
References: <44AE7785.74E63D70@ggr.co.uk>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44AE7785.74E63D70@ggr.co.uk> (Gordon Lack's message of "Fri,
	07 Jul 2006 16:02:29 +0100")
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gordon Lack <gml4410@ggr.co.uk>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] -hosts and -null enabling for autofs v4.1.x; "Gordon Lack" <gml4410@ggr.co.uk> adds:

gml4410>    Here is a simple patch to the system autofs startup script so that
gml4410> -hosts and -null is enabled in autofs 4.1.x.  This patch is actually
gml4410> against a RedHat autofs, but the same code is present in
gml4410> samples/rc.autofs.in.

gml4410>    For -hosts, it just translates the map name to /etc/auto.net if
gml4410> that is present and executable.

That bit looks sane at first glance.

gml4410>    For -null, it just adds the mountpoint location to the list of
gml4410> knownmaps, but doesn't do anything else.

This isn't exactly right.  It should "nullify" the next occurrence of the
given mount point, and then go away.  Consider a map like this:

/home -null
+auto.master
/home /etc/auto.home

Let's assume that +auto.master reads the master map from nis, and the nis
master map defines /home to point to some nis map.  The above would ignore
the /home entry in the nis master, and allow us to replace it with our own.

-Jeff
