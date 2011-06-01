From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] FedFS file system client support
Date: Wed, 01 Jun 2011 13:24:43 +0800
Message-ID: <1306905883.3280.109.camel@perseus.themaw.net>
References: <20110526163545.3676.52586.stgit@dali.1015granger.net>
	<1306728920.3292.3.camel@perseus.themaw.net>
	<8F5C8CC6-7F25-4F88-8877-F731E4BAB1A6@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=2ZjZ4EBxzPYuC5bJ6365ea5Jjhc=;
	b=OzRUhOW9ISoK29jgiGK2v1tVAZAIQlttLoChIGz6ExJFBLw7wefBXg0+70eot5Js6M9s9h+tVfSwUgFEoIT+GCpo9yIQdoOESXh7nBiXevYKu8BIU97LaDpgMu4CK0fezlci/w/KrXnFVKPl0BrxSBZR12UJBW50w2QTmMqb/D8=
In-Reply-To: <8F5C8CC6-7F25-4F88-8877-F731E4BAB1A6@oracle.com>
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
To: Chuck Lever <chuck.lever@oracle.com>
Cc: autofs@linux.kernel.org, fedfs-utils-devel@oss.oracle.com

On Tue, 2011-05-31 at 11:14 -0400, Chuck Lever wrote:
> On May 30, 2011, at 12:15 AM, Ian Kent wrote:
> 
> > On Thu, 2011-05-26 at 12:39 -0400, Chuck Lever wrote:
> >> Hi-
> >> 
> >> The next release of fedfs-utils will provide all necessary components
> >> for a Linux NFS client to participate in a FedFS domain as a file
> >> system client.  This new utility is intended to be a part of the
> >> upcoming release.
> >> 
> >> I'm interested in comments on this approach.  Ian had suggested a new
> >> lookup module, but a program map looked simpler to prototype and has
> >> the great advantage of no dependencies between fedfs-utils and autofs.
> >> If program maps have some nasty problem that require the use of a
> >> lookup module, we can take that next step.
> > 
> > The only difficulty with using a program map is that to use it you need
> > to know the name of the of the <key> (aka. /nfs4/<key>) since, at the
> > moment, autofs can't enumerate program map keys.
> 
> If I understand your comment correctly, the problem is how the client
> discovers FedFS domain names to use as keys.
> 
> As I understand it, FedFS does not currently have a mechanism for
> clients to discover FedFS domain names, like, say, AFS did with
> CellServDB.
> 
> Also, FedFS file system clients don't belong to a particular domain,
> so they don't have any idea what might be their "local" domain.  Any
> client can access any domain; security is provided by the underlying
> file system protocols.  The domains are just a way to organize the
> name spaces, without any regard to security administrative domains.
> 
> Thus, right now users and applications have to know a priori the whole
> pathname (or, Globally Useful Name, in FedFS parlance) in order to
> access a file resource via FedFS.
> 
> Are you suggesting there is a better design we could adopt that might
> prepare FedFS for a time when there is a mechanism for discovering
> FedFS domain names?

Only in so much as, to do this we would need to use a lookup module or
add autofs support for program maps to enumerate their keys and that
only makes sense if there is a way to enumerate domains, perhaps by
pre-configuring names.

Adding the ability for program maps to enumerate their keys has been
discussed before. Although it hasn't been done yet, using a NULL key to
ask the program for a list of its known keys should be straight forward.
Of course that assumes that the FedFS program map will allow the use of
a local list of domains to prime its cache and that autofs will function
ok for exiting and not yet existing keys (it should, if not I need to
fix it). The other catch is that we don't know if others using program
maps handle the case of a NULL key since they don't get them now. From
memory, a SEGV in a program map doesn't kill autofs and the request just
fails, as it should, but I'd need to check that.

To allow the use of external lookup modules I would need to formalize
and document the lookup module interface and provide a means to
configure a path to look in for modules or a way to specify an explicit
path to an external lookup module.

I think that will require a fair amount of change to separate the
internal autofs bits for modules from the internals independent bits.
I've been thinking about that for another request. I'm still not sure
about it since we have had some difficult problems relating to the order
of module dependent shared libraries being closed (or being released
anyway) and this likely would open that can of worms.

Mmm ...
