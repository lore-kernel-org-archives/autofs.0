From: "NeilBrown" <neilb@suse.de>
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
Date: Thu, 17 Feb 2022 13:57:26 +1100
Message-ID: <164506664650.10228.15450975168088794628@noble.neil.brown.name>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>,
 <164444398868.27779.4643380819577932837@noble.neil.brown.name>,
 <c1c21e74-85b0-0040-deb7-811a6fa7b312@altlinux.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645066656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6eRmy0xNlN2fdKPLYv2w1ctFFL+lJF1HVKt4VFf25I=;
        b=y+Vz5nmTyJNuiQEeFMHKyZ7LDH8M+5jd2outxvMTt0Pq7fjTBQ7JJ/9Cq0VhNLFILStZIV
        X4D6G+5sKivNtkFgRADy3rH8tu3qAjeowmKAC7vX0fCJB2ggVYe7zus+iTYkYomZ5KLFdN
        88K8z4qHbpqb/jCoDu40UrASh3eluQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645066656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6eRmy0xNlN2fdKPLYv2w1ctFFL+lJF1HVKt4VFf25I=;
        b=77MwZlgfpUOMcqYFWIWY2ePHl3tmJhJLc/klj49UTzzu+N9w2cvbBxZAuNjMYyWLXWSKih
        zb+t6zs3/WQNDDBQ==
In-reply-to: <c1c21e74-85b0-0040-deb7-811a6fa7b312@altlinux.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stanislav Levin <slev@altlinux.org>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Stanislav Levin wrote:
> 
> 
> This seems duplicate of https://www.spinics.net/lists/autofs/msg02389.html
> 

Yes it is - thanks for the link.
I wonder why the proposed fix isn't in git ....

Also, I cannot see that the new NS4_ONLY_REQUESTED is different from the
existing NFS4_VERS_MASK.
They are both set/cleared at exactly the same places.

Thanks,
NeilBrown
