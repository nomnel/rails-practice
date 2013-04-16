require 'spec_helper'
include AuthHelper

describe PostsController do
  fixtures :posts

  def valid_attributes
    {name: 'testuser',
     title: 'test post title',
     content: "some test content"}
  end


  context 'when signin' do
    before(:each) do
      http_login
    end

    describe "GET index" do
      it "assigns all posts as @posts" do
        get :index
        assigns(:posts).should eq(Post.order)
      end
    end

    describe "GET show" do
      it "assigns the requested post as @post" do
        get :show, { id: 2 }
        assigns(:post).should eq(posts(:post_2))
      end
    end

    describe "GET new" do
      it "assigns a new post as @post" do
        get :new
        assigns(:post).should be_a_new(Post)
      end
    end

    describe "GET edit" do
      it "assigns the requested post as @post" do
        get :edit, { id: 2 }
        assigns(:post).should eq(posts(:post_2))
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Post" do
          expect {
            post :create, { post: valid_attributes }
          }.to change(Post, :count).by(1)
        end

        it "assigns a newly created post as @post" do
          post :create, { post: valid_attributes }
          assigns(:post).should be_a(Post)
          assigns(:post).should be_persisted
        end

        it "redirects to the created post" do
          post :create, { post: valid_attributes }
          response.should redirect_to(Post.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved post as @post" do
          Post.any_instance.stub(:save).and_return(false)
          post :create, { post: {} }
          assigns(:post).should be_a_new(Post)
        end

        it "re-renders the 'new' template" do
          Post.any_instance.stub(:save).and_return(false)
          post :create, { post: {} }
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested post" do
          Post.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, { id: 2, post: { 'these' => 'params' } }
        end

        it "assigns the requested post as @post" do
          post = Post.find(2)
          post.title = 'foo'
          put :update, { id: 2, post: { title: 'foo' } }
          assigns(:post).should eq(post)
        end
      end

      describe "with invalid params" do
        it "assigns the post as @post" do
          post = Post.find(2)
          post.title = ''
          Post.any_instance.stub(:save).and_return(false)
          put :update, { id: 2, post: { title: '' } }
          assigns(:post).should eq(post)
        end

        it "re-renders the 'edit' template" do
          post = Post.find(2)
          post.title = ''
          Post.any_instance.stub(:save).and_return(false)
          put :update, { id: 2, post: { title: '' } }
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested post" do
        expect {
          delete :destroy, { id: 2 }
        }.to change(Post, :count).by(-1)
      end

      it "redirects to the posts list" do
        delete :destroy, { id: 2 }
        response.should redirect_to(posts_url)
      end
    end
  end

  context 'when not signed in' do
    describe "GET index" do
      it "assigns all posts as @posts" do
        get :index
        assigns(:posts).should eq(Post.order)
      end
    end

    describe "GET show" do
      it "assigns the requested post as @post" do
        get :show, { id: 2 }
        assigns(:post).should eq(posts(:post_2))
      end
    end

    describe "GET new" do
      before { get :new }
      it { should respond_with 401 }
    end

    describe "GET edit" do
      before { get :edit, { id: 2 } }
      it { should respond_with 401 }
    end

    describe "POST create" do
      before { post :create, { post: valid_attributes } }
      it { should respond_with 401 }
    end

    describe "PUT update" do
      before { put :update, { id: 2, story: { title: 'foo' } } }
      it { should respond_with 401 }
    end

    describe "DELETE destroy" do
      before { delete :destroy, { id: 2 } }
      it { should respond_with 401 }
    end
  end
end
