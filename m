From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: compatibility with solaris '[no]browse' mount option
Date: Mon, 14 Jun 2004 18:15:55 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16590.9115.824969.138598@segfault.boston.redhat.com>
References: <16589.63971.33237.4865@segfault.boston.redhat.com>
	<40CE2099.8050605@sun.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40CE2099.8050605@sun.com>
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
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] compatibility with solaris '[no]browse' mount option; Mike Waychison <Michael.Waychison@Sun.COM> adds:

Michael.Waychison> -----BEGIN PGP SIGNED MESSAGE-----
Hash> SHA1

Michael.Waychison> Jeff Moyer wrote:
>> Hello,
>> 
>> I've currently got a request to support the browse mount option.  It
>> seems do-able entirely in the init script (and this seems the right
>> place).  Would there be any objections to such an approach?
>> 
>> -Jeff
>> 
>> _______________________________________________ autofs mailing list
>> autofs@linux.kernel.org
http> //linux.kernel.org/mailman/listinfo/autofs

Michael.Waychison> How would you be able to do browsing from the init
Michael.Waychison> script given the protocol restrictions imposed by
Michael.Waychison> autofs4?  Autofs4 uses the magic pgid value as well as
Michael.Waychison> requiring a pipe fd to do communication.

I'm not quite that oblivious.  Close, but not quite.  ;)

Michael.Waychison> If you are simply looking towards translating the browse
Michael.Waychison> option to the ghosting used in automount4, then by all
Michael.Waychison> means go for it :) However please note that you will
Michael.Waychison> have to handle this in the daemon as well as it is
Michael.Waychison> possible to nest indirect maps:

Ahh, that's what I was looking for (and Mike Blandford had touched on this
as well in his reply).

Michael.Waychison> If you are willing to wait, I've been working on the
Michael.Waychison> autofs implementation I described at
Michael.Waychison> http://lkml.org/lkml/2004/1/6/167 that will support
Michael.Waychison> browsing/lazy mounts.  I will be releasing it to the
Michael.Waychison> community in the coming weeks pending some approvals..

I look forward to seeing it.  However, this is no substitute for adding
this bit of compatibility to autofs4.

Thanks!

-Jeff
