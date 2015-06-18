From: Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] autofs: handle old configuration format
Date: Wed, 17 Jun 2015 20:52:14 -0700
Message-ID: <5582406E.2090401@fb.com>
References: <1434558586-9442-1-git-send-email-jbacik@fb.com> <1434587998.2649.12.camel@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=zjVMt2BKuHkNL2m5KewXHyg38HTrj1x5MXzAP1kbzPo=;
 b=BwFgn6jRrEiWecLvoY3pADLn5qMe91vopIcT5KC6Mx2xiQVd6MRFX4Gm56FqCQCxcSzk
 jeutNgZ8rWS0xha1oWl4Dq6zGlRAT5Z2xh9221BvA3howEDSc+CeiaMWUC2XifBzZSVO
 iUDXOnt62vejMOUf26YYfSwzZflDx7hdDO0= 
In-Reply-To: <1434587998.2649.12.camel@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <ikent@redhat.com>
Cc: autofs@vger.kernel.org

On 06/17/2015 05:39 PM, Ian Kent wrote:
> Hi Josef,
>
> Hope you are well.
>
> On Wed, 2015-06-17 at 09:29 -0700, Josef Bacik wrote:
>> This is a patch to fix
>>
>> http://bugzilla.centos.org/view.php?id=8614
>>
>> The configuration stuff was redone and it broke backwards compatiblity.
>
> OK, but I put quite a bit of effort in to not do that.
>
> I thought it more likely I'd get complaints from people not realizing an
> old configuration left in place would override changes in the new
> configuration.
>
> Can you give me an example of the problem you have seen please.
>
>> Unfortunately this was backported to Centos/RHEL, so configurations that were
>> working in 6.4 suddenly broke in 6.6, which is not helpful.  Fix this by
>> noticing if we are looking at the old configuration file, strip out the DEFAULT_
>> bit of the variable if it is there and tolower the rest of the string.  This
>> makes it so our old configuration works properly and now people get their home
>> dirs automounted properly with either versions of autofs.  Thanks,
>
> The way this is supposed to work is that the new configuration file is
> read and then the old one is read and anything in the old configuration
> file should override anything in the new one.
>
> When looking up configuration values if the key isn't found and the key
> starts with "DEFAULT_" the the key is looked for again without the
> "DEFAULT_". Also, key comparisons are case insensitive so that shouldn't
> make a difference.

Oh now I realize why it's not working.  When you do defaults_get_schema 
you are looking up the new values, so your check in conf_lookup isn't 
helping anything, because we aren't looking up DEFAULT_*, we're looking 
up the new values.  And since we don't have those variables set in 
autofs.conf they don't get set until we load the old things, and so we 
have DEFAULT_* set in the conf but not the normal variables.  So we can 
do what I've done here, or change conf_lookup to add the DEFAULT_ to the 
front of anything we search for if we can't find it.  Thanks,

Josef

