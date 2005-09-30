From: Jim Kusznir <kusznir@eecs.wsu.edu>
Subject: Re: Autofs LDAP info
Date: Thu, 29 Sep 2005 20:54:50 -0700
Message-ID: <433CB70A.7080105@eecs.wsu.edu>
References: <433C86AC.1010100@eecs.wsu.edu>
	<Pine.LNX.4.58.0509300851010.22929@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509300851010.22929@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Ian Kent wrote:

>On Thu, 29 Sep 2005, Jim Kusznir wrote:
>
>  
>
>>Hello all:
>>
>>I've been tasked with making AutoFS get its maps from a Windows 2003 
>>Active Directory server via LDAP.  I know AutoFS works with LDAP in some 
>>fashon or another, however the documentation seems very sparce, and 
>>information on the net seems very fragmented and contradictory in areas.
>>
>>My primary questions at this point:
>>
>>What schema(s) does the latest AutoFS support?  Does it support 
>>standards such as NisMap?  (I've found both "yes" and "no" answers to 
>>this on the net, and no details in either)
>>    
>>
>
>autofs supports the NisMap and automountMap schemas.
>
>I've recently become aware of a couple of problems.
>
>The autofs-4.1.3 in RHEL doesn't seem to ba able to talk to the Sun LDAP 
>server however autofs-4.1.4 appears to work OK.
>
>The schema attributes used by Sun (automountMap) implementations have 
>probably been incorrect since before I started maintaining autofs and 
>I've perpetuated that without realizing the problem. Now we likely have 
>a bunch of people that will be inconvenienced if I fix it. In particular 
>autofs uses the "cn" attribute to contain the map key but I believe this 
>should be the "automountKey" attribute.
>
>  
>
>>How are maps entered in such schema?
>>
>>Are there any HOWTOs that cover LDAP specifically?  (I'm familiar with 
>>the amd-autofs howto at linuxconsulting, however I haven't found any 
>>useful (as of yet) LDAP info in there).
>>    
>>
>
>Have you looked at the LDAP examples in the samples directory of the 
>tarball?
>
>  
>
I actually haven't found the tarball yet.  So far, all I've found is the
RHEL RPMS (distributed through RH).  They don't appear to include the
examples (I did look on my devel system a fair bit, but found nothing
but a few configure readme's.

Where is the autofs project homepage / tarball download?  (Google seems
to point me to a bunch of howtos and blog-type pages).

--Jim
