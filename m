From: Jeff Layton <jlayton@redhat.com>
Subject: Re: unable to automount windows C$
Date: Wed, 13 May 2009 07:54:09 -0400
Message-ID: <20090513075409.7a962fe5@tleilax.poochiereds.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A5B0A.1060701@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0A5B0A.1060701@themaw.net>
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

On Wed, 13 May 2009 13:30:50 +0800
Ian Kent <raven@themaw.net> wrote:

> Ian Kent wrote:
> >> May 13 14:43:28 gw automount[15573]: mount_mount: mount(generic):
> >> calling mount -t cifs -s -o username=USERNAME,password=PASSWORD
> >> //xp0/C\$ /tmp/auto6t8L4W
> 
> Ohh, I get it, the "\" is a path separator for mount.cifs and I think
> the handling of it may have changed recently ish.

Around a year ago, yes.

> 
> So catch 22, autofs must escaped the "$" to prevent it being interpreted
> as a macro and the generic mount module has no special knowledge of cifs
> so it can't do anything about it. Worse, since "\" is a valid path
> separator for UNC paths we can't just check the fs type and translate
> them all. For example, what if we get :\\\\<server>\\service as the
> location?
> 

Right -- and it's even worse than that. '\' is a valid character in
posix path components. It's perfectly legitimate (though insane) to
have a file named:

/home/jlayton/crazy\file

'crazy\file' is a valid file/dir name.

I did a small writeup on this for the mount.cifs(8) manpage -- see the
section called 'SERVICE FORMATTING AND DELIMITERS'.

I think the only real way to solve this is to make sure that autofs
doesn't try to escape these characters before it calls mount. I don't
think mount does any variable interpolation, and I know mount.cifs
doesn't so there shouldn't be any need for escape chars before '$'
signs, assuming you're not handing these off to a shell of some sort.

-- 
Jeff Layton <jlayton@redhat.com>
