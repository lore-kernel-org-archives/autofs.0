From: Ian Kent <raven@themaw.net>
Subject: Re: basedn in /etc/sysconfig/autofs
Date: Thu, 06 Sep 2007 11:11:03 +0800
Message-ID: <1189048263.3102.8.camel@raven.themaw.net>
References: <46DE1128.2020109@oracle.com>
	<1188994602.3119.5.camel@raven.themaw.net>
	<46DEEAC4.80100@schrodinger.com>
	<C9AD2899A176C0499022697035E7625A39EDC6@houmbx5.anadarko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C9AD2899A176C0499022697035E7625A39EDC6@houmbx5.anadarko.com>
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
To: "Wolfe, Allan" <Allan.Wolfe@anadarko.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-09-05 at 12:57 -0500, Wolfe, Allan wrote:
> Multiple search paths would be beneficial as well for service search
> descriptor support.   e.g.:
> "ou=autofs,ou=services,dc=example,dc=com:ou=autofs_group1,ou=services,dc
> =example,dc=com"

I'm about to start work on this so specification of (multiple) basedn
will be possible.

> 
> -----Original Message-----
> From: autofs-bounces@linux.kernel.org
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Simon Gao
> Sent: Wednesday, September 05, 2007 12:44 PM
> To: Ian Kent
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] basedn in /etc/sysconfig/autofs
> 
> Ian Kent wrote:
> > On Wed, 2007-09-05 at 10:15 +0800, wengang wang wrote:
> >   
> >> Hi,
> >> A custom complained that:
> >> //<==
> >> In RHEL4 it was possible to set a "basedn" variable in the 
> >> /etc/sysconfig/autofs file which served as a basedn for LDAP lookups 
> >> performed by the automounter.
> >>
> >> However, this has been removed in RHEL5.
> >> //<==
> >> It is true that setting it in /etc/openldap/ldap.conf is an 
> >> alternative,
> >>     
> >
> > No.
> >
> >   
> >> the custom doesn't want do as that because /etc/openldap/ldap.conf is
> 
> >> automatically edited by the redhat config tools authconfig and 
> >> system-config-authentication.
> >> So I want to know for what the basedn is removed from 
> >> /etc/sysconfig/autofs.  I checked all the change logs and readmes in 
> >> autofs-5.0.1, but didn't find basedn metioned.
> >>     
> >
> > In version 5 the base dn is calculated, depending on how you specify 
> > the map.
> >
> > Describe the problem and I'll try and give a sensible answer.
> >
> > Ian
> >   
> I also have a related question about basedn in /etc/sysconfig/autofs.
> 
> You can put in root level basedn like "dc=example,dc=com", or more lower
> level like "ou=autofs,ou=services,dc=example,dc=com". Would later case
> help the search by being more specific and therefore getting autofs map
> lot quicker? Or it makes not significant difference?
> 
> Simon
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> -----------------------------------------
> 
> Anadarko Confidentiality Notice:  
> This electronic transmission and any attached documents or other
> writings are intended only for the person or entity to which it is
> addressed and may contain information that is privileged,
> confidential or otherwise protected from disclosure.  If you have
> received this communication in error, please immediately notify
> sender by return e-mail and destroy the communication. Any
> disclosure, copying, distribution or the taking of any action
> concerning the contents of this communication or any attachments by
> anyone other than the named recipient is strictly prohibited.
