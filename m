From: Ian Kent <raven@themaw.net>
Subject: Re: Simple BINDS over SSL/TLS
Date: Fri, 04 May 2007 17:25:19 +0800
Message-ID: <1178270719.4111.14.camel@raven.themaw.net>
References: <20070502151939.GD9348@cartman.devries.tv>
	<20070502153310.GF9348@cartman.devries.tv> <4639F837.9030606@anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4639F837.9030606@anl.gov>
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
To: "Douglas E. Engert" <deengert@anl.gov>
Cc: autofs@linux.kernel.org

On Thu, 2007-05-03 at 09:56 -0500, Douglas E. Engert wrote:
> 
> peter@devries.tv wrote:
> > On Wed, May 02, 2007 at 11:19:39AM -0400, peter@devries.tv wrote:
> >> I was wondering if it is possible for autofs to do simple binds over
> >> TLS/SSL rather than having to do them over SASL.
> > 
> > This may not have been clear enough.  I want autofs to authenticate to
> > the LDAP server as a user but without the use of SASL. 
> 
> Looking at autofs-4.1.4, it looks like it only does anonymous,
> because it does not have a binddn or bindpw to use. It can use TLS,
> if the ldap.conf it uses has someting like:
> 
>   URI ldaps://your.ldap.server.name
>   TLS_CACERTDIR path to ca certs
> 
> The ldap library could fill in a binddn from a ldaprc, Its the  bindpw
> that the ldap library will not fill in, and autofs does not have an
> easy way to get it.
> 
> Speakinig of SASL, the best I can tell is 4.1.4 does not support it
> directly, but could with a patch to call
> 
>   ldap_sasl_interactive_bind_s
> 
> I had a working patch, but got side tracked. Are there any plans
> to add SASL support to autofs, such that it ends up in Debian distribution?

If the folks at Debian update to version 5 it's present.

Ian
