From: Ian Kent <raven@themaw.net>
Subject: RE: getting parameters to executable maps
Date: Wed, 21 Jun 2006 23:21:11 +0800
Message-ID: <1150903271.14524.9.camel@raven.themaw.net>
References: <1150901405.14524.3.camel@raven.themaw.net>
	<000101c69544$8a747300$9f5d5900$@org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <000101c69544$8a747300$9f5d5900$@org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: aptosca <aptosca@esseff.org>
Cc: autofs@linux.kernel.org

On Wed, 2006-06-21 at 08:08 -0700, aptosca wrote:
> 	I've been thinking about that but I'm not sure about it.
> 	Mainly because the information flow is from autofs to the program
> and
> 	autofs can't know what environment to set.
> 
> 	Are you perhaps suggesting we define one or so?
> 
> That's what I was thinking of. I kinda thought the command line option would
> be too messy. But adding a variable to the environment (either after the
> fork before the exec or before the fork and retracting it, depending on the
> impact on COW paging stuff?) would seem pretty benign.
> 
> I can imagine AUTOFS_OPTIONS having the whole options string, or
> AUTOFS_OPTIONS being just a new program_map option, depending on whether it
> was considered bad to let the map see all the options or not. Since it's all
> new stuff, it shouldn't break any existing code.
> 
> Having brought this all up, I'm not really sure how much I care now, though.
> It would have been nice, but even if it went in, we won't be able expect
> everybody we need to support to have a new version of autofs very soon, so
> we'll probably have to do something else. We're looking at pushing all the
> information into an ldap server since (I think) all the clients we care
> about support that.  I need to double back and check that that's a
> sufficiently flexible solution. It has the great benefit of not requiring
> custom code on the client.
> 
> I did like Ian's idea of a new lookup method. I'd love autofs to support an
> xmlrpc lookup. Much easier to implement a dynamic xmlrpc server than one
> that has a NIS or ldap interface. Would that be of interest to others?

Possibly, but someone who needs it and has access to an environment to
test it would need to write it. And then there's the issue of ongoing
support for me since I don't have such a setup. So kinda good idea but
kinda difficult to get exited about.

Ian
