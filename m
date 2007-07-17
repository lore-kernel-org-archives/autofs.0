From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 + ldap + ldap replication
Date: Tue, 17 Jul 2007 14:20:32 +0800
Message-ID: <1184653232.3188.37.camel@raven.themaw.net>
References: <469985DF.9010607@wesmo.com>
	<1184599068.3344.5.camel@raven.themaw.net>	<469BB868.4080603@wesmo.com>
	<x497ip0w4xj.fsf@segfault.boston.devel.redhat.com>
	<469BCCF4.50608@wesmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <469BCCF4.50608@wesmo.com>
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
To: Rich West <Rich.West@wesmo.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-07-16 at 15:54 -0400, Rich West wrote:
> Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
> lookup(ldap): searching for "(objectclass=automount)" under
> "ou=auto.master,dc=mydomain,dc=com"
> Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
> lookup(ldap): examining entries
> Jul 16 15:21:08 myhost automount[1852]: master_echo: .
> Jul 16 15:21:08 myhost automount[1852]: master_echo: .
> Jul 16 15:21:08 myhost automount[1852]: master_echo: :
> Jul 16 15:21:08 myhost automount[1852]: master_echo: .

This is a parse error that's not being handled.
What autofs is getting from the LDAP server can't be the same as what
it's getting from the master if the master is working.

Can you give us an example of the output from an LDAP search to both the
servers please.

Ian
