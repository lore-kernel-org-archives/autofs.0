From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 + ldap + ldap replication
Date: Wed, 08 Aug 2007 19:33:14 +0800
Message-ID: <1186572794.10729.109.camel@raven.themaw.net>
References: 46A62F05.4040806@wesmo.com <46B7CBBA.7080105@wesmo.com>
	<46B882A9.2040108@cs.ou.edu> <46B88EA1.3060707@wesmo.com>
	<46B8A351.1010901@cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46B8A351.1010901@cs.ou.edu>
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
To: jsummers@bachman.cs.ou.edu
Cc: Rich West <Rich.West@wesmo.com>, autofs@linux.kernel.org

On Tue, 2007-08-07 at 11:52 -0500, Jim Summers wrote:
> Rich West wrote:
> > Jim Summers wrote:
> > 
> > I have it in both /etc/ldap.conf and /etc/openldap/ldap.conf, and the
> > format is the same:
> > uri <type>://host:port/
> > For example:
> > uri ldap://ldap1.mydomain.com:389/ ldap://ldap2.mydomain.com:389/

btw, /etc/ldap.conf is used by nss_ldap which openldap and autofs don't
use.

/etc/openldap/ldap.conf is the one used by the openldap tools and the
ldap libraries and so is the place to list the servers.

Ian
