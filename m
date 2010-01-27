From: Ian Kent <raven@themaw.net>
Subject: Re: problem installing 5.0.5
Date: Wed, 27 Jan 2010 11:11:01 +0800
Message-ID: <4B5FAEC5.9050007@themaw.net>
References: <4B5958A8.2050308@gmail.com> <4B5D0FF1.1010701@themaw.net>
	<4B5E2BE9.8020701@gmail.com> <4B5EFB4D.9080808@themaw.net>
	<4B5F48B7.2010002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B5F48B7.2010002@gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Philip Ong Jr." <pongjr@gmail.com>
Cc: autofs@linux.kernel.org

On 01/27/2010 03:55 AM, Philip Ong Jr. wrote:
> I have not, how do I go about doing that?

Clone the git repository:

git clone git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git
cd autofs
./configure --disable-mount-locking --enable-ignore-busy
DEBUG=1 make

should work.

If this still doesn't work and you are not able to update your make then
consider grabbing the autofs5 package from CentOS 4u8 (if u8 is
available) and use that. That package is reasonably up to date wrt.
5.0.5. You will need to check when autofs5 was added to CentOS 4 because
it will require the kernel of at least that CentOS 4 update. Indeed, if
you do manage to build 5.0.5 from source (+ patches) and you do not have
a kernel with the version 5 patches it will refuse to start. So you need
to do this check anyway.

> 
> Phil
> 
> Ian Kent wrote:
>> On 01/26/2010 07:40 AM, Philip Ong Jr. wrote:
>>  
>>> I applied the patches starting from top to down...and now receiving
>>> error messages pertaining to conditional statements.
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-included-map-read-fail-handling.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-refactor-ldap-sasl-bind.patch
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.4-add-mount-wait-parameter.patch
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-special-case-cifs-escapes.patch
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-libxml2-workaround-configure.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-more-code-analysis-corrections.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-backwards-ifndef-INET6.patch
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-stale-init-for-file-map-instance.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-ext4-fsck-at-mount.patch
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-dont-use-master_lex_destroy-to-clear-parse-buffer.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-make-documentation-for-set-log-priority-clearer.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-timeout-in-connect_nb.patch
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-pidof-init-script-usage.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-check-for-path-mount-location-in-generic-module.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-dont-fail-mount-on-access-fail.patch
>>>
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-rpc-large-export-list.patch
>>>
>>> patch -p1 <
>>> /usr/src/autofs-5.0.5/patches/autofs-5.0.5-fix-memory-leak-on-reload.patch
>>>
>>>
>>> # ./configure --disable-mount-locking --enable-ignore-busy
>>>
>>> # DEBUG=1 make
>>>
>>> gcc -g -lpthread -rdynamic -pie -o automount automount.o indirect.o
>>> direct.o spawn.o module.o mount.o lookup.o state.o flag.o
>>> ../lib/autofs.a -ldl -lxml2 -lz -lpthread -lm
>>> : automount
>>> make[1]: Leaving directory `/usr/src/autofs-5.0.5/daemon'
>>> make[1]: Entering directory `/usr/src/autofs-5.0.5/modules'
>>> Makefile:75: Extraneous text after `else' directive
>>> Makefile:80: Extraneous text after `else' directive
>>> Makefile:80: *** only one `else' per conditional.  Stop.
>>> make[1]: Leaving directory `/usr/src/autofs-5.0.5/modules'
>>> make: *** [daemon] Error 2
>>>
>>> Thoughts?
>>>     
>>
>> Oh ... bummer, wonder how I've broken the patch series?
>>
>> I'll check it out and get back to you.
>> In the meantime, have you tried checking out the git repo and building
>> that?
>>
>> Ian
>>
>>   
