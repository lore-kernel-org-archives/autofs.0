From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in ldap
 automatically
Date: Fri, 25 Aug 2006 19:21:28 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
	<44EEA538.8090203@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44EEA538.8090203@inria.fr>
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

On Fri, 25 Aug 2006, Guillaume Rousse wrote:

> Ian Kent wrote:
> > On Thu, 24 Aug 2006, Guillaume Rousse wrote:
> > 
> >> autofs 5.0.1 isn't able to retrieve ldap master map automatically, as it
> >> did in 4.1.x:
> >> Aug 24 16:33:17 alceste automount[23385]: lookup_init: lookup(ldap):
> >> failed to get query dn
> >>
> >> When giving it an explicit dn as MASTER_MAP_NAME, everything is fine,
> >> however.
> > 
> > Some more info would be good.
> Unfortunatly, that's all I get even with maximum debug output configured:
> --verbose and --debug flags for automount
> LOGGING="debug" in configuration file
> 
> I use the following LDAP attributes:
> MAP_OBJECT_CLASS="automountMap"
> ENTRY_OBJECT_CLASS="automount"
> MAP_ATTRIBUTE="ou"
> ENTRY_ATTRIBUTE="cn"
> VALUE_ATTRIBUTE="automountInformation"
> 
> I'll try to run it in the debugger, but I have to fix my debug package
> first.

Can you give a couple of examples of you LDAP entries please.

Ian
