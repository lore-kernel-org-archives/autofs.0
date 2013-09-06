From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 2/2, 2nd attempt] samples/auto.smb: add logic to obtain
 credentials
Date: Fri, 06 Sep 2013 10:23:52 +0200
Message-ID: <52299118.4080103@ts.fujitsu.com>
References: <51081EF4.20105@ts.fujitsu.com>  <1359549686-7246-1-git-send-email-martin.wilck@ts.fujitsu.com>  <1359549686-7246-3-git-send-email-martin.wilck@ts.fujitsu.com> <1378454358.2311.1.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378455830; x=1409991830;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=7vIVXSAxAFkLN8yQkPh+0Wb3Rjen7VYvE6ZaAYWZqHU=;
  b=SrjE9oM2E4hRzXsL9JLTc0/93lr16qo366yUiUrfyvZTjJA42M2eylSK
   qIdCyzdiMhVxgYXzcL4BxcHv5X8zPKHbbpu4jNDT/VUwK+KDBLzTohS+6
   tAPUX/qR5qeWOjIg7RNIzRD6lVlfumr0mu+jDmCtV8QVPHZ/xY2gKJl9e
   himaa7AEPBCI1SXbKOdGR29r0YiYn/4GrwRF21z5cBhLmtQTRSp0WvrZi
   yiV3G5BCctVNu5r7loVPz9ak/0v3o;
In-Reply-To: <1378454358.2311.1.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On 09/06/2013 09:59 AM, Ian Kent wrote:

>> -$SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
>> +creds=/etc/creds/$key
>> +if [ -f "$creds" ]; then
>> +    opts="$opts"',uid=$UID,gid=$GID,credentials='"$creds"
>> +    smbopts="-A $creds"
>> +else
>> +    get_krb5_cache
>> +    if [ -n "$cache" ]; then
>> +        opts="$opts"',multiuser,cruid=$UID,sec=krb5i'
>> +        smbopts="-k"
>> +        export KRB5CCNAME=$cache 
>> +    else
>> +        opts="$opts"',guest'
> 
> Why add guest?

"guest" means "don't prompt for a password" which is what mount.cifs
will attempt to do if no credentials are available already (e.g. via
kerberos ticket). IMO that's what's needed for autofs, otherwise the
mount attempt might hang waiting for password input.

> Is that going to change the behavior of the existing script.

"guest" mode was all the previous script could do, thus it seems to have
been written with servers in mind that only offered guest access in the
first place (und thus wouldn't prompt for a password, either).

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
