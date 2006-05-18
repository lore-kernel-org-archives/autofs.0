From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Thu, 18 May 2006 15:38:19 +0200
Message-ID: <446C78CB.7060705@inria.fr>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
	<446251C5.5070407@inria.fr>
	<Pine.LNX.4.64.0605171035370.20033@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605171035370.20033@raven.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Ian Kent wrote:
> On Wed, 10 May 2006, Guillaume Rousse wrote:
> 
> Thanks for the feedback Guillaume.
> 
>> Ian Kent wrote:
>>> Hi all,
>>>
>>> It's time for an updated beta.
>>>
>>> autofs
>>> ======
>>>
>>> The package can be found at:
>>>
>>> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5
>>>
>>> It is autofs-5.0.0_beta2.tar.[gz|bz2]
>>>
>>> No source rpm is there as it can be produced by using:
>>>
>>> rpmbuild -ts autofs-5.0.0_beta2.tar.gz
>>>
>>> and the binary rpm by using:
>>>
>>> rpmbuild -tb autofs-5.0.0_beta2.tar.gz
>>>
>>> See the INSTALL file for information about configure options and
>>> kernel requirements.
>> I couldn't test it really yet, as mandriva development kernel is still
>> 2.6.14, however here are a few remarks:
>>
>> First, stripping binaries by default, especially during compilation, is
>> opposite behaviour of standard autotools-based procedure, where it only
>> occurs if you install with "make stripinstall". I need to have debug
>> symbols present when building a package, as they are automatically for
>> extracting them in a separate debug package. I've found that "make
>> DEBUG=1" would prevent stripping, but it also defines an additional
>> CFLAG with unknown result :/
> 
> If this is what I think it is then there may be a patch around that I can 
> use.
> 
> I'm not completely clear on what your saying though.
> Could you give more details please.
With a standard autotools (autoconf + automake), running ./configure && 
make && make install installs unstripped binaries. With current autofs 
build system, the same command install stripped binaries. This may be 
considered as couter-intuitive and non standard.

In a rpm building scenario, rpm takes cares of stripping them 
automatically after installation, so you may consider to be harmless to 
perform stripping during build, as the final result is the same. 
However, when you enable automatic debug package creation, rpm first 
extract debug symbols before stripping binaries, still in the final 
installation step. In this case, it is harmful to strip binaries during 
compilation.

Hence my advocacy to revert to only strip installed binaries, through a 
dedicated install target.

>> Second, the two attached patches don't apply anymore:
>> - autofs-4.1.4-signal-race-fix.patch seems to refer to parts of
>> automount.c not existing anymore
> 
> This patch is not relevant any more.
> The signal handling in the threaded environment is completely different.
> 
>> - autofs-4.1.1-get-best-mount.patch refer to a 4 args get_best_mount()
>> function that only has 3 args nowadays
> 
> This patch makes get_best_mount use a long timeout always instead of a 
> short timeout followed by long timeout if it the first rpc_ping fails.
> 
> I think that get_best_mount was not falling back to the long timeout so 
> this patch was used to work around it. I'm fairly sure that was fixed.
> 
> Anyway, get_best_mount will go away soon as the server selection code is 
> being re-written.
OK.

>> Third, the following patches still apply, but I got no clue about their
>> usefulness:
>> - autofs-4.1.0-hesiod-bind.patch
> 
> OK. I've seen this patch several times.
> No one has yet been able to explain what it's for.
> 
>> - autofs-4.1.0-loop.patch
> 
> I've seen this patch before as well.
> Not sure why this patch is not included.
> I'll review it again.
Jeff just suggested to drop it :)
