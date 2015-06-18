From: Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] autofs: handle old configuration format
Date: Wed, 17 Jun 2015 20:42:55 -0700
Message-ID: <55823E3F.2020001@fb.com>
References: <1434558586-9442-1-git-send-email-jbacik@fb.com> <1434587998.2649.12.camel@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=bBqmvvggQA1vr2egmXMtEWGYK+AKErL6A3picMqKz7c=;
 b=jKOf0EdWcyz+xnX66P+Jw96E2/RoK8v5cFBxo0DKcxOyOjkw9F9DxDtWDn1taoIpLRGa
 mOkLRBcPrUjHocVNVuvweyCO/L1iC1lfZ2mWOVU+LowA8c7BS1j0C9Qsnv7mfeCL7Joa
 FBRVgmwA2wQCMFJwZKXvCo00ecUZn823mi8= 
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
>
> And I'm pretty sure I strip white space too so extra spaces shouldn't
> cause a problem either.
>
> But clearly you have a case that I've missed which I'm keen to hear
> about.
>

Huh sorry I got confused by looking at the diffs that I thought you had 
dropped that bit, but now I remember looking at this code a few days 
ago.  I'm not sure why it's not working, our /etc/sysconfig/autofs looks 
something like this

DEFAULT_LOGGING="debug or some shit"
DEFAULT_MAP_OBJECT_CLASS="blah"
DEFAULT_ENTRY_OBJECT_CLASS="foo"
DEFAULT_MAP_ATTRIBUTE="something else"
DEFAULT_ENTRY_ATTRIBUTE="whatever"
DEFAULT_VALUE_ATTRIBUTE="bar"

When we upgrade it cycles through the normal map_object_class things 
instead of using ours, it thinks there's no schema.  With my change it 
works fine.  I don't have VPN access working at the moment so I can't 
screw around with it now, but if you want me to poke at it some more I 
can do it in the morning.  Thanks,

Josef
