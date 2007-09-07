From: Ian Kent <raven@themaw.net>
Subject: Re: basedn in /etc/sysconfig/autofs
Date: Fri, 07 Sep 2007 09:14:33 +0800
Message-ID: <1189127673.3078.8.camel@raven.themaw.net>
References: <46DE1128.2020109@oracle.com>
	<1188994602.3119.5.camel@raven.themaw.net>	<46DEEAC4.80100@schrodinger.com>
	<1189048182.3102.5.camel@raven.themaw.net>
	<x49myvzvoqs.fsf@segfault.boston.devel.redhat.com>
	<46E082B1.7060909@schrodinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46E082B1.7060909@schrodinger.com>
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
To: Simon Gao <gao@schrodinger.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-09-06 at 15:44 -0700, Simon Gao wrote:
> Jeff Moyer wrote:
> > Ian Kent <raven@themaw.net> writes:
> >
> >   
> >> On Wed, 2007-09-05 at 10:43 -0700, Simon Gao wrote:
> >>     
> >>> I also have a related question about basedn in /etc/sysconfig/autofs.
> >>>
> >>> You can put in root level basedn like "dc=example,dc=com", or more lower
> >>> level like "ou=autofs,ou=services,dc=example,dc=com". Would later case
> >>> help the search by being more specific and therefore getting autofs map
> >>> lot quicker? Or it makes not significant difference?
> >>>       
> >> This configuration option is RHEL4 specific.
> >> I would need to revisit that code to answer that.
> >> Perhaps Jeff will be able to help.
> >>     
> >
> > Well, since it is the search base, yes, confining it more will limit
> > the scope of the search.
> >
> > -Jeff
> >   
> So for autofs 5.0.1 on RHEL 5, one can add basedn line to
> /etc/sysconfig/autofs? Just curious what's the reason to remove it or
> not include it as default in the first place?
> 

No you can't.

This config item isn't part of upstream autofs 4, it's RHEL specific, so
it wasn't "removed" it just wasn't present in the code base that version
5 started from.

The primary driver for the LDAP changes were to reduce the number of
queries to the server (from 9 to 1) and what we have in version 5 is
what we ended up with.

In any case this will be added to version 5.

Ian
