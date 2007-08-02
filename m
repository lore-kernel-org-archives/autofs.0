From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AutoFS5 Ldap base strangeness
Date: Thu, 02 Aug 2007 17:56:08 -0400
Message-ID: <x491weleh3b.fsf@segfault.boston.devel.redhat.com>
References: <46B23DFB.7060200@cs.ou.edu>
	<x49odhpek9z.fsf@segfault.boston.devel.redhat.com>
	<46B247E7.3020902@cs.ou.edu>
	<x498x8tej4o.fsf@segfault.boston.devel.redhat.com>
	<46B24D15.4070306@cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46B24D15.4070306@cs.ou.edu> (Jim Summers's message of "Thu\,
	02 Aug 2007 16\:31\:01 -0500")
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
Cc: autofs@linux.kernel.org

Jim Summers <jsummers@bachman.cs.ou.edu> writes:

> Jeff Moyer wrote:
>> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
>>
>>> Jeff Moyer wrote:
>>>> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
>>>>
>>>>> hello all,
>>>>>
>>>>> I am just about to get my automounting working with autofs5 and my ldap.  I am
>>>>> able to start the automount daemon and it loads and reads /home map, which
>>>>> points at ou=auto.home for the user's home directory location and options.
>>>>>
>>>>> but when i attempt to su - <user> it can not mount the user's home.  here is
>>>>> what i see in the ldap server's access log:
>>>>> ===
>>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 SRCH
>>>>> base="cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
>>>>> filter="(&(objectClass=automount)(|(automountKey=tmac)(automountKey=/)))"
>>>>> attrs="automountKey automountInformation"
>>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 RESULT err=0 tag=101 nentries=0
>>>>> etime=0
>>>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=2 UNBIND
>>>>> ===

OK, now I'd like to get the ldap server messages that preceded this.
Specifically, I'd like to see the query done for
(&(objectclass=automountMap)(ou=auto.home)).  I think that's the
schema you're using.

-Jeff
