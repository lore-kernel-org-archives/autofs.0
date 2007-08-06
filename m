From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: AutoFS5 RPM version
Date: Mon, 06 Aug 2007 16:16:28 -0500
Message-ID: <46B78FAC.9040807@cs.ou.edu>
References: <46B23DFB.7060200@cs.ou.edu>	<x49odhpek9z.fsf@segfault.boston.devel.redhat.com>	<46B247E7.3020902@cs.ou.edu>
	<1186111734.3573.1.camel@raven.themaw.net>
Reply-To: jsummers@bachman.cs.ou.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1186111734.3573.1.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Thu, 2007-08-02 at 16:08 -0500, Jim Summers wrote:
>> Jeff Moyer wrote:
>>> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
>> i do have the following installed:
>>
>> autofs-5.0.1-20
>> autofs-debuginfo-5.0.1-20
>>
>> and by the way, i am building those from source rpms. before i actually do an 
>> rpmbuild i run a patch that Ian had sent me.  it fixes a syntax issue when you 
>> have a dc that is named ou.  after the last updates it quit working, so i 
>> grabbed the src.rpm and rebuilt again.  i guess the patch hasn't made into the 
>> repos yet.
> 
> That is in autofs-5.0.2-21 which should be on the mirrors.

Hi Ian,

I was able to pick up the autofs with the 'dc=ou' patch in it on an FC7 
installation I have.  But when I tried a yum -y update on an FC6 machine it 
updated to:  autofs-5.0.1-0.rc3.32, which does not seem to have the patch in 
it.  Do you know if the FC6 repos's will have the patched version?

Thank again for all of your help.

--jim


> 
> Ian
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------
