From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: Re: AutoFS5 Ldap base strangeness
Date: Thu, 02 Aug 2007 16:08:55 -0500
Message-ID: <46B247E7.3020902@cs.ou.edu>
References: <46B23DFB.7060200@cs.ou.edu>
	<x49odhpek9z.fsf@segfault.boston.devel.redhat.com>
Reply-To: autofs@linux.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49odhpek9z.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
> 
>> hello all,
>>
>> I am just about to get my automounting working with autofs5 and my ldap.  I am
>> able to start the automount daemon and it loads and reads /home map, which
>> points at ou=auto.home for the user's home directory location and options.
>>
>> but when i attempt to su - <user> it can not mount the user's home.  here is
>> what i see in the ldap server's access log:
>> ===
>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 SRCH
>> base="cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
>> filter="(&(objectClass=automount)(|(automountKey=tmac)(automountKey=/)))"
>> attrs="automountKey automountInformation"
>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 RESULT err=0 tag=101 nentries=0
>> etime=0
>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=2 UNBIND
>> ===
>>
>> the weird part of the above is, in the first line it says "cn=sfu" but then
>> also says automountKey=tmac
>>
>> the su command is:  su - tmac
>>
>> so the correct username is tmac not sfu.
>>
>> any ideas where the sfu thing is coming from??
>>
>> is the info cached somewhere?  I ask because when I start the daemon, i can
>> see in the logs where it does:
>> ===
>> [31/Jul/2007:15:35:40 -0500] conn=8536 op=1 SRCH
>> base="ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
>> filter="(objectClass=automount)" attrs="1.1"
>> [31/Jul/2007:15:35:40 -0500] conn=8536 op=1 RESULT err=0 tag=101 nentries=617
>> etime=0
>> ===
>> which is returning 617 entries.
>>
>> not sure what i have wroong here??
> 
> Please send a debug log:
>   http://people.redhat.com/jmoyer

Will do Jeff.  Just to cut some time out how can i generate the debug log?  In 
/etc/sysconfig/autofs, i have set:

LOGGING="debug"
and
OPTIONS="-v"

but that seems to only increase the noise in /var/log/messages a little.

i do have the following installed:

autofs-5.0.1-20
autofs-debuginfo-5.0.1-20

and by the way, i am building those from source rpms. before i actually do an 
rpmbuild i run a patch that Ian had sent me.  it fixes a syntax issue when you 
have a dc that is named ou.  after the last updates it quit working, so i 
grabbed the src.rpm and rebuilt again.  i guess the patch hasn't made into the 
repos yet.

thanks again


> 
> -Jeff
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------
