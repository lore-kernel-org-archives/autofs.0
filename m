From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map	in	ldap
 automatically
Date: Fri, 25 Aug 2006 17:29:11 +0200
Message-ID: <44EF1747.5010103@inria.fr>
References: <44EDB98B.8050201@inria.fr>	
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>	
	<44EEA538.8090203@inria.fr>	
	<Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>	
	<44EEEC55.2040101@inria.fr>	
	<Pine.LNX.4.64.0608252033290.30811@raven.themaw.net>	
	<44EEF1E6.7040008@inria.fr>
	<1156511928.30971.12.camel@raven.themaw.net>
	<1156512652.30971.19.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1156512652.30971.19.camel@raven.themaw.net>
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
> On Fri, 2006-08-25 at 21:18 +0800, Ian Kent wrote:
>> On Fri, 2006-08-25 at 14:49 +0200, Guillaume Rousse wrote:
>>> Ian Kent wrote:
>>>> On Fri, 25 Aug 2006, Guillaume Rousse wrote:
>>>>
>>>>> Ian Kent wrote:
>>>>>>> I'll try to run it in the debugger, but I have to fix my debug package
>>>>>>> first.
>>>>> gdbdoesn't complain anymore about missing symbols, but despite my
>>>>> attempts, I've been unable to set a working break point on faulty
>>>>> function (get_query_dn).
>>>> Is your LDAP client able to query this stuff with only the information 
>>>> used in the autofs queries (the ones you see in the debug output)?
>>> Not sure to understand you here. I get nothing else in my debug output
>>> than: failed to get query dn
>> Have you setup syslog.conf to log daemon.* to somewhere?
>> You won't get much at all unless syslog is sending it some where.
>>
>> Mmmm .. I see I don't debug print the query in get_query_dn.
>>
>> But looking at the code, if there is a map name the filter would be
>> something like:
>>
>> (&(objectclass=<map_obj_class>)(<map_attr>=<map name>))
>>
>> so I think for your defaults that would be
>>
>> (&(objectclass=automountMap)(ou=auto.master))
>>
>> It gets the base dn from the output of this query.
>> If that doesn't work nothing else does, but you already know that.
> 
> Oh .. btw .. to get quick info you can just stick an error print in
> like:
> 
> error(LOGOPT_ANY, "query %s", query);
> 
> and it should show up in the log regardless of the debug setting.
OK, I found the issue: when all you have is mapname, and you have to use
default server and base, you should use LDAP_SCOPE_SUBTREE scope for
your query, not LDAP_SCOPE_ONELEVEL.

Here is a patch that fixes the problem:
diff -Naur autofs-5.0.1/modules/lookup_ldap.c
autofs-5.0.1-fix-ldap-lookup/modules/lookup_ldap.c
--- autofs-5.0.1/modules/lookup_ldap.c  2006-07-13 04:11:39.000000000 -0400
+++ autofs-5.0.1-fix-ldap-lookup/modules/lookup_ldap.c  2006-08-25
11:19:59.000000000 -0400
@@ -802,7 +802,7 @@
                              MODPREFIX "error forming query string");
                        return 0;
                }
-               scope = LDAP_SCOPE_ONELEVEL;
+               scope = LDAP_SCOPE_SUBTREE;
        } else {
                if (sprintf(query, "(objectclass=%s)", class) >= l) {
                        debug(LOGOPT_NONE,


> I find getting a gdb session going is a hassle much of the time.
It depends on your setup. I usually build my packages on mandriva
cluster, and install then on my own machines for testing them, rather
than directly building and installing locally.
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
