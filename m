From: Ian Kent <raven@themaw.net>
Subject: Re: autofs - nfs with localhost
Date: Fri, 11 Feb 2005 10:11:02 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502111005580.6415@wombat.indigo.net.au>
References: <20050209170812.GA3000@hamburg.neofonie.priv>
	<16907.42002.201785.995963@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16907.42002.201785.995963@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Rasmus Hahn <rassahah@neofonie.de>

On Thu, 10 Feb 2005, Jeff Moyer wrote:

> ==> Regarding [autofs] autofs - nfs with localhost; Rasmus Hahn <rassahah@neofonie.de> adds:
> 
> rassahah> Hello Mr & Mrs Autofs-Reader, im using autofs-4.1.3 and want to
> rassahah> use an map-entry like
> 
> rassahah>   -port=12215,mountport=12215,nfsvers=3,soft,tcp,ro localhost:/.
> 
> rassahah> For some reason the automounter believes in beeing smarter than
> rassahah> me, and instead of mounting using the nfs daemon it could find on
> rassahah> port 12215 it uses a `mount --bind' to mount the root filesystem
> rassahah> without nfs.  How can i disable this to force automount to use
> rassahah> NFS? The manpages didnt reveal anything about this, is it an
> rassahah> experimental feature?
> 
> rassahah> (background: actually i dont want to remount my / somewhere else,
> rassahah> but using an ssh-tunnel on port 12215 with an nfsd on the other
> rassahah> end).
> 
> Sorry, there is no option to configure that.  So is this a feature request?
> ;)
> 

I've looked at that part of the code a couple of times recently as Chris 
is interested in tidying it up.

It certainly looks like it needs work. What was I thinking, doh.

Anyway, it also looks like that if the nosymlink option is specified it 
will work as requested here.

Ian
