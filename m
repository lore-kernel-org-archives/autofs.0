From: Peter Staubach <staubach@redhat.com>
Subject: Re: [patch] Underscore in hostnames
Date: Mon, 11 Dec 2006 10:57:11 -0500
Message-ID: <457D7FD7.5030702@redhat.com>
References: <20061207232212.GA1994@sleipnir.redhat.com>	<1165809391.3380.8.camel@raven.themaw.net>	<20061211120507.GA2629@sleipnir.redhat.com>	<x49lkler00t.fsf@segfault.boston.devel.redhat.com>
	<1165851275.3380.42.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1165851275.3380.42.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Mon, 2006-12-11 at 09:16 -0500, Jeff Moyer wrote:
>   
>> ==> On Mon, 11 Dec 2006 10:05:07 -0200, Fabio Olive Leite <fleite@redhat.com> said:
>>
>> Fabio> On Mon, Dec 11, 2006 at 12:56:31PM +0900, Ian Kent wrote:
>> Fabio> > 
>> Fabio> > Not valid at all.
>> Fabio> > And they are tolerated because the admin explicitly configures DNS to
>> Fabio> > violate the RFC.
>>
>> Fabio> The sad thing is that mount(1) does no such validation, and allows one
>> Fabio> to mount an NFS export on a hostname containing underscores just fine.
>> Fabio> So we can end up in a situation where automount does not allow the
>> Fabio> user to configure a working NFS mount she has.
>>
>> Yes, and when coupled with the fact that some other vendors' products
>> allow this sort of thing by default, I think we may have to support
>> it.  I'm a big fan of sticking to the RFC's, but in this case, I think
>> we should make an exception.
>>     
>
> Ya .. I reality I don't feel as strongly as I made out.
>
> I did want to see if there was anyone else that did have an opinion
> though.
>
> I'll merge the patch unless anyone else feels strongly against it.

Do we know which other vendors products support '_' as a valid character
in a hostname?

I might be more in favor of fixing the NFS mount code than modifying
autofs in this fashion.

    Thanx...

       ps
