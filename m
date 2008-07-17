From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs doesn't look at second LDAP server
Date: Thu, 17 Jul 2008 11:14:08 +0800
Message-ID: <1216264449.22783.66.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F05192E66@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F05192E66@permls05.wde.woodside.com.au>
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org


On Wed, 2008-07-16 at 09:20 +0800, Coe, Colin C. (Unix Engineer) wrote:
> Jul 13 04:03:01 las006 automount[31280]: parse_ldap_config:
> lookup(ldap): user: (null), secret: unspecified, client principal:
> (null) credential cache: (null)
> Jul 13 04:03:01 las006 automount[31280]: parse_ldap_config:
> lookup(ldap): user: (null), secret: unspecified, client principal:
> (null) credential cache: (null)
> Jul 13 04:03:01 las006 automount[31280]: find_server: trying server
> ldaps://aether.woodside.com.au:636
> Jul 13 04:03:01 las006 automount[31280]: find_server: trying server
> ldaps://aether.woodside.com.au:636

I wonder if it's getting the server from the config at all?
It should be.

LDAP_URI="ldaps://ldap2.woodside.com.au:636 ldaps://ldap1.woodside.com.au:636"

given that the name here is different from the one being used.
Can you send the full debug log to me please.

But that's probably another issue.

Ian
