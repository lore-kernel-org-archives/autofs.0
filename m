From: Ian Kent <raven@themaw.net>
Subject: Re: [Fwd: linking issues with ldap]
Date: Thu, 24 Jan 2008 14:35:05 +0900
Message-ID: <1201152905.3061.31.camel@raven.themaw.net>
References: <47977B5B.300@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47977B5B.300@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org


On Wed, 2008-01-23 at 18:37 +0100, Guillaume Rousse wrote:
> Sending again, first attempt failed.
> email message attachment (linking issues with ldap.eml)
> > -------- Forwarded Message --------
> > From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
> > To: autofs@linux.kernel.org
> > Subject: linking issues with ldap
> > Date: Thu, 17 Jan 2008 16:48:42 +0100
> > 
> > Hello list.
> > 
> > Latest release (5.0.3) attempt to link against libldap_r, and fails on
> > mandriva because of unresolved pthread symbols. However, according to
> > ldap maintainer, libldap_r is supposed to be a private library. Hence
> > autofs should use -lldap, not -lldap_r. Attached patch fix this.

Think you missed one.
Can you try this patch and let me know how it goes please.
http://www.kernel.org/pub/linux/daemons/autofs/v5/autofs-5.0.3-correct-ldap-lib.patch

Ian
