From: Ian Kent <raven@themaw.net>
Subject: Re: I have some patches for the autofs-4.x daemon - what
 to do with them?
Date: Fri, 03 Dec 2010 12:27:00 +0800
Message-ID: <1291350420.3062.12.camel@perseus>
References: <AANLkTinCncue4d-g_c0fSF1smE3i8cT-GT+w-eDygGPF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <AANLkTinCncue4d-g_c0fSF1smE3i8cT-GT+w-eDygGPF@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Bill Ryder <bill.ryder.nz@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2010-12-01 at 11:07 +1300, Bill Ryder wrote:
> Where should I submit those?
> 
> 
> Or should I just put it on github or something for anyone who wants
> them since the autofs-4.x daemon series has been deprecated in favour
> of the autofs-5.x series.

Probably, but it might be good for me to create a directory on
kernel.org and save them their, but a readme with applicable version and
usage information would probably make sense.

> 
> 
> We have about 2 or 3,000 clients where I work and autofs is crucial to
> our operation.
> 
> 
>  We use ldap and use a simple automount structure. We have about 450
> mountpoints and 19 maps. 
> 
> 
> I don't like autofs-5 because I cant' fix automounts individually.
> It's very convenient to be able to restart individual mounts. Also
> when a daemon core dumps they don't take out every single map. Also I
> prefer automount to run the mount command itself - rather than
> building it into the daemon.

Right, but v5 still uses mount(8) as v4 did.

I understand your need for segregation but it would be good to get v5 to
a state where this isn't a problem for you any more.

Tell me more about the "take out every single map" problem. With current
v5 you should be able to just start it up again and your mounts should
continue to function. The problem of course come when you have a
non-responsive server, then you end up re-connecting to non-responsive
mounts. Of course, there is still a time where new mounts cannot be made
until the startup.

> 
> 
> The main work I've done is to build in retrying mounts depending on
> the errors returned by mount (with our client count we overload our
> fileservers often which causes retryable errors, and sometimes a
> client will try to mount 100 or so mount points in a very short amount
> of time which causes some tcp client port exhaustion - which is also
> retryable).

So you can't export to allow clients to use insecure ports?

> 
> 
> I've fixed a nasty bug that will crash a daemon if an error occurs
> while mounting, and another request comes in for a nonexistent mount
> point.
> 
> 
> I  have a flag which helps our samba servers - particular when
> accessed by macs. There's an option that tells the daemon to return
> 'not found' for any mount which starts with a . or contains a '*'
> without looking up ldap. This makes it very fast to handle macs
> looking to .DS_store and many other dot files/directories when someone
> browses the top of a map with ghosting on. The '*' was quite amusing
> (for me anyway) because every so often you'd see a '*' directory in an
> automount directory. Turns out someone had escaped the '*' and ldap
> returns the first match. 
> 
> 
> And I reinstated the ldap-cleanup patch which is a much cleaner way to
> handle the multiple schemas - particularly important because we
> recently moved to rfc2307bis because I was sick of people being able
> to mount
> 
> 
> /vol/AmounTPoINT and /vol/amountpoint and so on. 

Sounds useful, we should talk more about these things.

> 
> 
> Anyway. What do do with this stuff?
> 
> 
> Bill Ryder
> 
> 
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
