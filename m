From: Ian Kent <raven@themaw.net>
Subject: Re: mount: mount point /home/user does not exist
Date: Tue, 07 Jul 2009 09:46:09 +0800
Message-ID: <4A52A8E1.7030307@themaw.net>
References: <4A4D3408.40103@idilia.com> <4A4D8B40.9020402@themaw.net>
	<4A52038C.9090008@idilia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A52038C.9090008@idilia.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Filipe Brandenburger <lists.filbranden@idilia.com>
Cc: autofs@linux.kernel.org

Filipe Brandenburger wrote:
> Hi Ian,
> 
> Ian Kent wrote:
>> Filipe Brandenburger wrote:
>>> Recently I had failures in some hosts when mounting home directories, in
>>> some cases more than one host at a time.
>>
>> This does sound a bit like a known problem.
>> A bunch of patches have gone into RHEL-4 U8 which resolved almost all
>> reported problems. You will need to log a bug or update to U8 to check.
> 
> Thanks for your answer.
> 
> Would upgrading autofs from 4.1.3-234 to 4.1.3-238 be enough, or do I
> need to upgrade to the latest kernel as well?

Above I was actually referring to the kernel, although I didn't make
that clear. The RHEL-4.8 kernel update fixed almost all reported kernel
related problems (there were a couple).

> 
> Would using the "autofs5" package in RHEL4 be better in this sense? Do
> you know if that package is as stable as autofs 4 is in RHEL4?

That a trick question, right?
As the maintainer I will always recommend version 5.

The RHEL-4 autofs5 package is essentially the same as the RHEL-5 autofs
package except that it's a release behind, as updates are back ported.
The back porting of RHEL-5 updates will be somewhat more selective from
RHEL-4.9 onward.

Ian
