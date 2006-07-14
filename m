From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: -hosts and -null enabling for autofs v4.1.x
Date: Fri, 14 Jul 2006 09:31:16 -0400
Message-ID: <x49bqrsia8r.fsf@redhat.com>
References: <44AE7785.74E63D70@ggr.co.uk>
	<x49u05laae9.fsf@segfault.boston.redhat.com>
	<44B780FA.DC42CB24@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44B780FA.DC42CB24@ggr.co.uk> (Gordon Lack's message of "Fri,
	14 Jul 2006 12:33:14 +0100")
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
To: Gordon Lack <gml4410@ggr.co.uk>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] -hosts and -null enabling for autofs v4.1.x; "Gordon Lack" <gml4410@ggr.co.uk> adds:

gml4410> Jeff Moyer wrote:
>> 
gml4410> For -null, it just adds the mountpoint location to the list of
gml4410> knownmaps, but doesn't do anything else.
>> 
>> This isn't exactly right.  It should "nullify" the next occurrence of the
>> given mount point, and then go away.
 
gml4410>    That isn't how automount maps are supposed to work (at least
gml4410> not Sun ones, according to how I read the documentation).  Only
gml4410> the *first* occurrence of a mountpoint is supposed to be used -
gml4410> that is meant to override *all* following occurences.

Yes, you are correct.  This line in the man page is what confused me:

     The -null map cancels a previous map for the directory indi-
     cated.

Thanks!

Jeff
