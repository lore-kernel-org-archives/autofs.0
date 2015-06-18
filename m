From: Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] autofs: handle old configuration format
Date: Thu, 18 Jun 2015 09:41:02 -0700
Message-ID: <5582F49E.6010507@fb.com>
References: <1434558586-9442-1-git-send-email-jbacik@fb.com>	 <1434587998.2649.12.camel@pluto.fritz.box> <5582406E.2090401@fb.com> <1434609425.3898.11.camel@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=LLmbfUQolEVQ6E3npREhCdFasci2AQt3x2D/07ZTsdI=;
 b=kod8ps4MRCD5tgE6oIufr0wZaNNOaWSBaLyKU3+MFYcGB3bwqKwUzVy9HKnaZg1t3EpA
 SUfnhAT8ySCzT/ERlQLTRldtMG5mYyyJU/8i+bs+p5SB8swNhC9N84oAsywssxUGiRHh
 JmqXtwSkRhvS3VqZcTjrHswMQU5ATsm6zOg= 
In-Reply-To: <1434609425.3898.11.camel@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <ikent@redhat.com>
Cc: autofs@vger.kernel.org

On 06/17/2015 11:37 PM, Ian Kent wrote:
> On Wed, 2015-06-17 at 20:52 -0700, Josef Bacik wrote:
>> On 06/17/2015 05:39 PM, Ian Kent wrote:
>>> Hi Josef,
>>>
>>> Hope you are well.
>>>
>>> On Wed, 2015-06-17 at 09:29 -0700, Josef Bacik wrote:
>>>> This is a patch to fix
>>>>
>>>> https://urldefense.proofpoint.com/v1/url?u=http://bugzilla.centos.org/view.php?id%3D8614&k=ZVNjlDMF0FElm4dQtryO4A%3D%3D%0A&r=cKCbChRKsMpTX8ybrSkonQ%3D%3D%0A&m=2pMrg2mSVkYIRbq9PsXATsOwwHLUv7M%2FC1vSREeuAMA%3D%0A&s=bce3fa3f755b02b8849de7338fa74adb71fd4cd84a2a318820c29830ed16f699
>>>>
>>>> The configuration stuff was redone and it broke backwards compatiblity.
>>>
>>> OK, but I put quite a bit of effort in to not do that.
>>>
>>> I thought it more likely I'd get complaints from people not realizing an
>>> old configuration left in place would override changes in the new
>>> configuration.
>>>
>>> Can you give me an example of the problem you have seen please.
>>>
>>>> Unfortunately this was backported to Centos/RHEL, so configurations that were
>>>> working in 6.4 suddenly broke in 6.6, which is not helpful.  Fix this by
>>>> noticing if we are looking at the old configuration file, strip out the DEFAULT_
>>>> bit of the variable if it is there and tolower the rest of the string.  This
>>>> makes it so our old configuration works properly and now people get their home
>>>> dirs automounted properly with either versions of autofs.  Thanks,
>>>
>>> The way this is supposed to work is that the new configuration file is
>>> read and then the old one is read and anything in the old configuration
>>> file should override anything in the new one.
>>>
>>> When looking up configuration values if the key isn't found and the key
>>> starts with "DEFAULT_" the the key is looked for again without the
>>> "DEFAULT_". Also, key comparisons are case insensitive so that shouldn't
>>> make a difference.
>>
>> Oh now I realize why it's not working.  When you do defaults_get_schema
>> you are looking up the new values, so your check in conf_lookup isn't
>> helping anything, because we aren't looking up DEFAULT_*, we're looking
>> up the new values.  And since we don't have those variables set in
>> autofs.conf they don't get set until we load the old things, and so we
>> have DEFAULT_* set in the conf but not the normal variables.  So we can
>> do what I've done here, or change conf_lookup to add the DEFAULT_ to the
>> front of anything we search for if we can't find it.  Thanks,
>
> Yes, that looks to be the case.
>
> I can't just strip the DEFAULT_ prefix on adding values because there
> could be configuration key names that are meant to have the prefix.
>
> So I think it's best to try and handle this in the conf_lookup()
> function.
>
> You may get some conflicts with this as it's against current upstream
> but if you can resolve them, does this patch resolve the problem?
>
> If you have difficulty with conflicts then give me the package revision
> and I'll back port the patch to it so you can test it.
>
> autofs-5.1.1 - fix config old name lookup
>

That did it, thanks!

Josef

