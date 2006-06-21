From: Ian Kent <raven@themaw.net>
Subject: Re: getting parameters to executable maps
Date: Wed, 21 Jun 2006 22:50:05 +0800
Message-ID: <1150901405.14524.3.camel@raven.themaw.net>
References: <000101c68e5a$6f30d570$4d928050$@org>
	<Pine.LNX.4.64.0606211121140.3748@raven.themaw.net>
	<x49mzc6hbvz.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49mzc6hbvz.fsf@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 2006-06-21 at 09:33 -0400, Jeff Moyer wrote:
> ==> Regarding RE: [autofs] getting parameters to executable maps; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Mon, 12 Jun 2006, aptosca wrote:
> >> I have a network service that defines a filesystem namespace. I'd like
> >> to write an executable map that uses that service to return map entries
> >> to automount. Abstractly, the executable map takes the namespace path,
> >> queries the web service, and returns a map entry to automount. The map
> >> entry is either a pointer to a real filesystem or an -fstype=autofs
> >> entry that causes the executable map to be executed again when/if an
> >> entry in the directory is touched.
> 
> raven> I've thought about this and I can't think of any easy way to achieve
> raven> this.
> 
> raven> I don't like the idea of changing the internals of the way program
> raven> maps are called.
> 
> raven> One way to do this would be to write an autofs lookup module to
> raven> handle this map source rather than use a program map.
> 
> Is there any way we could achieve this via setting some environment
> variables?

I've been thinking about that but I'm not sure about it.
Mainly because the information flow is from autofs to the program and
autofs can't know what environment to set.

Are you perhaps suggesting we define one or so?

Ian
