From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in ldap
 automatically
Date: Fri, 25 Aug 2006 09:24:11 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
References: <44EDB98B.8050201@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44EDB98B.8050201@inria.fr>
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

On Thu, 24 Aug 2006, Guillaume Rousse wrote:

> autofs 5.0.1 isn't able to retrieve ldap master map automatically, as it
> did in 4.1.x:
> Aug 24 16:33:17 alceste automount[23385]: lookup_init: lookup(ldap):
> failed to get query dn
> 
> When giving it an explicit dn as MASTER_MAP_NAME, everything is fine,
> however.

Some more info would be good.

Ian
