From: Filipe Brandenburger <lists.filbranden@idilia.com>
Subject: Re: mount: mount point /home/user does not exist
Date: Mon, 06 Jul 2009 10:00:44 -0400
Message-ID: <4A52038C.9090008@idilia.com>
References: <4A4D3408.40103@idilia.com> <4A4D8B40.9020402@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A4D8B40.9020402@themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hi Ian,

Ian Kent wrote:
> Filipe Brandenburger wrote:
>> Recently I had failures in some hosts when mounting home directories, in
>> some cases more than one host at a time.
> 
> This does sound a bit like a known problem.
> A bunch of patches have gone into RHEL-4 U8 which resolved almost all
> reported problems. You will need to log a bug or update to U8 to check.

Thanks for your answer.

Would upgrading autofs from 4.1.3-234 to 4.1.3-238 be enough, or do I 
need to upgrade to the latest kernel as well?

Would using the "autofs5" package in RHEL4 be better in this sense? Do 
you know if that package is as stable as autofs 4 is in RHEL4?

Thanks!
Filipe
