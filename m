From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 2/2, 2nd attempt] samples/auto.smb: add logic to obtain
 credentials
Date: Fri, 06 Sep 2013 11:40:33 +0200
Message-ID: <5229A311.5040307@ts.fujitsu.com>
References: <51081EF4.20105@ts.fujitsu.com>   <1359549686-7246-1-git-send-email-martin.wilck@ts.fujitsu.com>   <1359549686-7246-3-git-send-email-martin.wilck@ts.fujitsu.com>  <1378454358.2311.1.camel@perseus.fritz.box>  <52299118.4080103@ts.fujitsu.com> <1378459591.2311.28.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378460436; x=1409996436;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=d9BXVM3JT0Ty1scnKE4pNPfP18N3OidpBH7ZH//U1co=;
  b=tKk54i3RcG/LW+3LNVkiEnRLcrhQFMMKi1iL5c/vNtorfFi1q3ZVVnug
   N8nV8cLE2jLQyIMjmrirdIT4DKATtY9h+hJAvmDppu/AUmvB11p09Db6v
   tHeR04xHe/kBpJOzealuGJYGTrpds1lqcOqy61xL8VyYSUZKFmntqhA9P
   dJNygo8cjiVyuQe9wxHhe2CB6tEhG7G12leKsalW+Xc4h7ENb94I5jN9h
   w3X0cU5rZswRS80LVF8O1Z8BOPNmj;
In-Reply-To: <1378459591.2311.28.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On 09/06/2013 11:26 AM, Ian Kent wrote:
> On Fri, 2013-09-06 at 10:23 +0200, Martin Wilck wrote:
>> On 09/06/2013 09:59 AM, Ian Kent wrote:
>>
>>>> -$SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
>>>> +creds=/etc/creds/$key
>>>> +if [ -f "$creds" ]; then
>>>> +    opts="$opts"',uid=$UID,gid=$GID,credentials='"$creds"
>>>> +    smbopts="-A $creds"
>>>> +else
>>>> +    get_krb5_cache
>>>> +    if [ -n "$cache" ]; then
>>>> +        opts="$opts"',multiuser,cruid=$UID,sec=krb5i'
>>>> +        smbopts="-k"
>>>> +        export KRB5CCNAME=$cache 
>>>> +    else
>>>> +        opts="$opts"',guest'
>>>
>>> Why add guest?
>>
>> "guest" means "don't prompt for a password" which is what mount.cifs
>> will attempt to do if no credentials are available already (e.g. via
>> kerberos ticket). IMO that's what's needed for autofs, otherwise the
>> mount attempt might hang waiting for password input.
>>
>>> Is that going to change the behavior of the existing script.
>>
>> "guest" mode was all the previous script could do, thus it seems to have
>> been written with servers in mind that only offered guest access in the
>> first place (und thus wouldn't prompt for a password, either).
> 
> From my POV auto.smb is an example program map that happens to get
> installed. I don't think it was never meant to be sophisticated.

Sure. We might as well keep it as it is, or just provide the new one
alongside the old one as another example.

> You are saying that adding guest doesn't change anything as it is the
> default when no credentials are provided, correct?

That's right.

Martin

-- 
Dr. Martin Wilck
PRIMERGY System Software Engineer
x86 Server Engineering

FUJITSU
Fujitsu Technology Solutions GmbH
Heinz-Nixdorf-Ring 1
33106 Paderborn, Germany
Phone:			++49 5251 525 2796
Fax:			++49 5251 525 2820
Email:			martin.wilck@ts.fujitsu.com
Internet:		http://ts.fujitsu.com
Company Details:	http://ts.fujitsu.com/imprint
