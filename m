From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in ldap
 automatically
Date: Fri, 25 Aug 2006 09:22:32 +0200
Message-ID: <44EEA538.8090203@inria.fr>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
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
To: autofs@linux.kernel.org

Ian Kent wrote:
> On Thu, 24 Aug 2006, Guillaume Rousse wrote:
> 
>> autofs 5.0.1 isn't able to retrieve ldap master map automatically, as it
>> did in 4.1.x:
>> Aug 24 16:33:17 alceste automount[23385]: lookup_init: lookup(ldap):
>> failed to get query dn
>>
>> When giving it an explicit dn as MASTER_MAP_NAME, everything is fine,
>> however.
> 
> Some more info would be good.
Unfortunatly, that's all I get even with maximum debug output configured:
--verbose and --debug flags for automount
LOGGING="debug" in configuration file

I use the following LDAP attributes:
MAP_OBJECT_CLASS="automountMap"
ENTRY_OBJECT_CLASS="automount"
MAP_ATTRIBUTE="ou"
ENTRY_ATTRIBUTE="cn"
VALUE_ATTRIBUTE="automountInformation"

I'll try to run it in the debugger, but I have to fix my debug package
first.
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
