From: Anca Emanuel <anca.emanuel@gmail.com>
Subject: Re: [patch -next] autofs4: double lock typo in autofs4_write()
Date: Fri, 13 Jan 2012 17:25:50 +0200
Message-ID: <CAJL_dMvBycLdpbvOowcLjcjM3CZp=j+i6_mvLzZiTTGONuD_pA@mail.gmail.com>
References: <20120113144113.GA25667@elgon.mountain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2NYusUpnWBiM6CzsTJ3G2mFPjzWEZjPi6tD7gR/+MFw=;
        b=Z2wnzmBCiymlVRmyP+6/S+ML/4BHWRiTa45AlDRIxuySkXayLFfdRZxqWgndfhKKAR
         c8Jfmw37Aho5gK7HwGwO+YgPj6/fdKOrKuZ6lBCVjudQs+B81glk1qvH1q3cwlWJykUl
         aqMnZpk0+CX892m5d+zZ9gIMoY1IyD4sqrsCE=
In-Reply-To: <20120113144113.GA25667@elgon.mountain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi, this is already reported:
https://lkml.org/lkml/2012/1/13/104

and tested by Dave.
