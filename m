From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: Query automount maps
Date: Wed, 16 Jan 2008 07:00:23 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F051929F8@permls05.wde.woodside.com.au>
References: <x49tzlex1ba.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <x49tzlex1ba.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org


Hi Jeff

So automount only checks to see if the maps have changed when it tries
to mount a directory?  What happens if the map source (NIS, LDAP, etc)
is temporarily unreachable?  Is that map marked as deleted?  

Thanks

CC

-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com] 
Sent: Wednesday, 16 January 2008 5:48 AM
To: Coe, Colin C. (Unix Engineer)
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Query automount maps

"Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au> writes:

> Hi Ian and all
>
> Is there a way I can ask the automount process running on a client
what
> maps it has?  I'd like to be able to say "tell me all the maps you
know
> about" or "tell me the server:/path/to/somewhere for
> /nfs/server/some/path".  Does this make sense?
[...]
> I'm really just after a way of checking that autofs map changes are
> picked up by the clients.

It doesn't actually make sense, and here's why: the automounter won't
recognize the update until a mount is triggered.  As such, you can
just trigger a mount and compare what gets mounted with what you
expect.  Is there some reason that this won't work for you?

Cheers,

Jeff

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
