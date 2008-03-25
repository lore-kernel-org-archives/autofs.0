From: "Paul B. Henson" <henson@acm.org>
Subject: Re: sudo and autofs
Date: Tue, 25 Mar 2008 12:51:02 -0800 (PST)
Message-ID: <Pine.GSO.4.55.0803251247380.15841@loogie.intranet.csupomona.edu>
References: <1203828797.5413.355.camel@localhost> <47E391D4.9050107@inria.fr>
	<Pine.LNX.4.64.0803210832590.3306@simba.math.ucla.edu>
	<Pine.GSO.4.55.0803241350360.14855@loogie.intranet.csupomona.edu>
	<Pine.LNX.4.64.0803242227320.21910@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0803242227320.21910@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

On Mon, 24 Mar 2008, Jim Carter wrote:

> There are complaints that rpc.gssd only looks for /tmp/krb5cc_${UID}
> whereas pam_krb5 uses /tmp/krb5cc__{UID}_XXXXXX (randomized by mktemp).
> There is supposed to be a patch for this but I haven't discovered yet
> whether I have it.

Even Red Hat 4 appears to have an rpc.gssd that does a more extensive
search for credentials, presumably any reasonably modern distribution will
as well.

> Access will not happen unless the KDC has nfs/${fqdn}@REALM for both hosts
> (can't mount) and for the user (can't create security context for
> read/write).

With newer versions of rpc.gssd you can tell it to use supplied credentials
rather than machine credentials for the mount and for root access. This
allows you to use secure NFS from a client on which you cannot obtain a
host principal. It's not particularly convenient though...



-- 
Paul B. Henson  |  (909) 979-6361  |  http://www.csupomona.edu/~henson/
Operating Systems and Network Analyst  |  henson@csupomona.edu
California State Polytechnic University  |  Pomona CA 91768
