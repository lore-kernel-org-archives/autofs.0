From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Tue, 29 Nov 2005 11:34:03 -0500
Message-ID: <438C82FB.50706@us.ibm.com>
References: <20051116101740.GA9551@RAM>  <Pine.LNX.4.63.0511271807100.2406@donald.themaw.net>  <438B3C34.2050509@us.ibm.com> <1133219572.27824.24.camel@localhost.localdomain> <Pine.LNX.4.58.0511290918060.26303@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0511290918060.26303@wombat.indigo.net.au>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Badari Pulavarty <pbadari@gmail.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent wrote:
> We'll need to do an analysis of all callers of the revalidate method.
You are right. Searching through the sources, it would appear that I 
missed fixing autofs and devfs.  Everyone else just defines a revalidate 
routine but doesn't call one.  You may find devfs to be interesting 
because they have code to determine whether they need to release the 
i_sem lock or not.  I am working on an updated patch to include the 
changes needed for these two modules.

Will

