From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] Fix for ldap_search when multiple cn's are in
 one LDAP entry.
Date: Thu, 6 Jan 2005 13:54:59 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501061353100.6246@wombat.indigo.net.au>
References: <41B9F4EB.2050202@redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41B9F4EB.2050202@redhat.com>
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
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Fri, 10 Dec 2004, Chris Feist wrote:

> This patch fixes a bug in the ldap search which will only use the first 
> mount point found in an LDAP entry.
> 
> For example if an ldap entry looks like this:
> 
> dn: cn=%T%I_apps, nisMapName=auto_home, ou=foo.bar
> nismapname: auto_home
> objectClass: top
> objectClass: nisobject
> nismapentry: foo.bar.ti.com:/vol/vol6/TI_apps
> cn: %T%I_apps
> cn: TI_apps
> 
> Then the auto_home map will only be used in /%T%I_apps

But the key is unique by definition.

I'll add this patch but I'm not sure it's correct wrt autofs map 
definition.

Comments?

Ian
