From: Ian Kent <raven@themaw.net>
Subject: Re: autofs segfault at startup on x86_64
Date: Wed, 4 Jan 2006 11:14:26 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0601041100370.27455@wombat.indigo.net.au>
References: <43BA56CF.6050109@inria.fr>
	<1136287828.2350.10.camel@eagle.themaw.net>
	<43BA7286.50101@inria.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43BA7286.50101@inria.fr>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Tue, 3 Jan 2006, Guillaume Rousse wrote:

> Ian Kent wrote:
> > On Tue, 2006-01-03 at 11:49 +0100, Guillaume Rousse wrote:
> > 
> >>I've been instructed to report this here instead of kernel bugzilla:
> >>http://bugzilla.kernel.org/show_bug.cgi?id=5561
> >>
> > 
> > 
> > Hi Guillaume,
> > 
> > Yes, I'll follow up on this.
> > 
> > Perhaps a simple patch for configure would be a good workaround while I
> > check out what's required. It appears you have spent a fair bit of time
> > on this already but it would help if you could give me a brief
> > description of your understanding of the problem and what you have found
> > out so far.
> Autofs requires to be compiled with -DLDAP_DEPRECATED on x86_64
> platforms when linked against openldap >= 2.3, otherwise it
> automatically triggers a segfault in openldap library during
> initialisation (more exactly, in ldap_set_option() call from
> do_connect() in lookup_ldap.c).

Thanks for the info.

I chaecked the thread you reffered to about this and I think that a 
configure patch for autofs-4.1.4 would be adequate for that version. 
People using older versions could backport it.

The only question I have to answer is whether it would be OK to use the 
-DLDAP_DEPRECATED on all platforms for openldap >= 2.3 or perhaps > 2.2?

> 
> OpenLDAP maintainers suggest to either use this flags automatically
> during compilation, or to change autofs code to use newest API.

Yes. The LDAP code is badly in need of work. I have a patch in the queue 
which greatly improves the code and upgrading the API calls for 4.1.5 and 
beyond will probably prove to be a good idea. I'll also need to check how 
far back the newer API calls have been available to make sure that people 
with older OpenLDAP versions don't break. And there's the RedHat Directory 
Server in Fedora to support as well now.

I'm not very familiar with the LDAP API, I just use what I need to get the 
job done in autofs so any information that might be volunteered by people 
more familiar would be greatly appreciated.

Ian
