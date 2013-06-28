From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Linking against libldap_r instead of libldap?
Date: Thu, 27 Jun 2013 22:42:49 -0300
Message-ID: <CAEySpB4wm76DEJE-752Qd=_vtEMMi_vzr=eGu7RfUaJmbVT2GQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=pMRibQYispnFI/VW6wiAkjqgWr5jaDmA23J05RTvOow=;
        b=e+VTXp+5YjWjRHiKBVGcOcYy1FLcKQBaG81aeSSBjVMfsw0B93NgrL37f8J9NKaniq
         qVlJ9awwB+U9AaDDIZWk8WhY5EfJBqYqg7jVRFsu3vCWmj8VNz2h9iCuDb2R2fbl5MlO
         RWHSTXWlySvBzs0GosrTClEeOTfXusOKXn61sEgAEym2LKR5nMEgmidrFHizqXMyCtt0
         E5SM/2w3ZpnQ7NIIpQ8yvFgnYnASkGRwwj76KLm4wjku7gyClfFDPS67Ke2gKKC43ZBG
         2oV7p77AxpAdn0jVl8ier6rbQH7szYjQIaIAOLCX8/gSdwRymKF3BIUOF1elPT0W40ns
         qypQ==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs <autofs@vger.kernel.org>

Hi,

I'm investigating one segmentation fault report (multiple occurrences)
in automount where the OpenSSL context (using LDAP with TLS) is
clearly corrupted. Reading OpenSSL documentation I found that the
the library needs to be correctly initialized in order to run in a multi-
threaded environment. I also found that *only* the reentrant build of
the OpenLDAP libraries (libldap_r) initialize openssl for multi-threading.

By default (since commit 04dfd15590a) automount is linked against
libldap (non-reentrant), but I failed to find the reason behind the change.
Could you help me understand why it shouldn't be linked against
libldap_r?

Thanks,
Leonardo
