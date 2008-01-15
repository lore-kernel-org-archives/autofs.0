From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Query automount maps
Date: Tue, 15 Jan 2008 17:20:41 -0500
Message-ID: <x49prw2wx1i.fsf@segfault.boston.devel.redhat.com>
References: <BAC1D28A5AB852439A6914CA7AB4E63F051929F8@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F051929F8@permls05.wde.woodside.com.au>
	(Colin C. Coe's message of "Wed\, 16 Jan 2008 07\:00\:23 +0900")
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org

"Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au> writes:

> Hi Jeff
>
> So automount only checks to see if the maps have changed when it tries
> to mount a directory?

Correct.

> What happens if the map source (NIS, LDAP, etc) is temporarily
> unreachable?  Is that map marked as deleted?

That depends on what version of autofs you are running.  Up until very
recently, autofs version 4 would actually exit if a map source was no
longer available!  I don't know what the autofs5 behaviour was, but it
wasn't exactly right either.  Now it services requests from its cache
until the backing store is back online.  I'm not sure the fix for this
has made it into any released v4 package, but Ian incorporated this fix
into his 5.0.3 release.

Cheers,

Jeff
